//
//  EarTrainingSession.swift
//  TrainingModule
//
//  Created by Ertan Yağmur on 23.02.2026.
//

import Foundation

public protocol EarTrainingSessionProtocol: Sendable {
  var states: AsyncStream<EarTrainingState> { get }
  
  func dispatch(_ action: EarTrainingAction) async
}

public actor EarTrainingSession: EarTrainingSessionProtocol {
  
  private var state: EarTrainingState
  
  // MARK: Dependencies
  private let engine: EarTrainingEngine
  private let strategy: QuestionStrategy
  private let audioPlayer: AudioPlaying
  private let timing: EarTrainingTiming
  
  private var orchestrationTask: Task<Void, Never>?
  
  private var statesContinuation: AsyncStream<EarTrainingState>.Continuation
  public let states: AsyncStream<EarTrainingState>
  
  // MARK: Lifecycle
  public init(
    mode: EarTrainingMode,
    engine: EarTrainingEngine,
    strategy: QuestionStrategy,
    audioPlayer: AudioPlaying,
    timing: EarTrainingTiming = .default
  ) {
    let context = EarTrainingContext(mode: mode)
    
    self.state = EarTrainingState(context: context)
    
    var tempContinuation: AsyncStream<EarTrainingState>.Continuation!
    
    self.states = AsyncStream { continuation in
      tempContinuation = continuation
    }
    
    self.statesContinuation = tempContinuation
    self.engine = engine
    self.strategy = strategy
    self.audioPlayer = audioPlayer
    self.timing = timing
    
    statesContinuation.yield(state)
  }
  
  deinit {
    statesContinuation.finish()
    orchestrationTask?.cancel()
  }
  
  // MARK: Public
  public func dispatch(_ action: EarTrainingAction) async {
    let result = engine.reduce(state: state, action: action)
    
    if result.events.isEmpty && result.state == state {
      return
    }
    
    orchestrationTask?.cancel()
    
    state = result.state
    statesContinuation.yield(state)
    
    orchestrationTask = Task { [weak self] in
      guard let self else { return }
      
      do {
        try await self.handle(result.events)
      } catch {
        if Task.isCancelled {
          await self.cleanupAfterCancellation()
        } else {
          print(error)
        }
      }
    }
  }
  
  // MARK: Private
  private func handle(_ events: [EarTrainingEvent]) async throws {
    for event in events {
      try await handle(event)
    }
  }
  
  private func handle(_ event: EarTrainingEvent) async throws {
    switch event {
    case .answeredCorrect:
      try await handleAnsweredCorrect()
    case .answeredWrong:
      try await handleAnsweredWrong()
    case .audioReplayRequested:
      await playCurrent()
    case .sessionStarted:
      try await handleSessionStarted()
    }
  }
  
  private func handleSessionStarted() async throws {
    let firstQuestion = strategy.nextQuestion(from: state)
    
    state = engine.reduce(state: state, action: .begin(firstQuestion)).state
    statesContinuation.yield(state)
    
    try await Task.sleep(nanoseconds: timing.initialPlayDelay)
    try Task.checkCancellation()
    
    await playCurrent()
  }
  
  private func handleAnsweredCorrect() async throws {
    let nextQuestion = strategy.nextQuestion(from: state)
    
    try await Task.sleep(nanoseconds: timing.correctNextDelay)
    try Task.checkCancellation()
    
    state = engine.reduce(state: state, action: .next(nextQuestion)).state
    statesContinuation.yield(state)
    
    await playCurrent()
  }
  
  private func handleAnsweredWrong() async throws {
    try await Task.sleep(nanoseconds: timing.wrongReplayDelay)
    try Task.checkCancellation()
    
    switch state.context.mode {
    case .practice:
      state = engine.reduce(state: state, action: .retryCurrentQuestion).state

    case .game:
      let nextQuestion = strategy.nextQuestion(from: state)
      
      state = engine.reduce(state: state, action: .next(nextQuestion)).state
    }
    
    statesContinuation.yield(state)
    await playCurrent()
  }
  
  private func playCurrent() async {
    guard let question = state.currentQuestion else { return }
    try? await audioPlayer.play(resourceName: question.pitchClass.audioResourceName)
  }
  
  private func cleanupAfterCancellation() {
    guard state.phase == .resolvingAnswer else { return }
    
    state = engine.reduce(state: state, action: .retryCurrentQuestion).state
    statesContinuation.yield(state)
  }
  
}
