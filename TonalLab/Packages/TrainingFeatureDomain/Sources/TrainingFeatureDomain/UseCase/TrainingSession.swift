//
//  TrainingSession.swift
//  TrainingModule
//
//  Created by Ertan Yağmur on 23.02.2026.
//

import Foundation

public actor TrainingSession {
  
  private var state: TrainingState
  private let engine: TrainingEngine
  private let strategy: QuestionStrategy
  private let audioPlayer: AudioPlaying
  private let timing: TrainingTiming
  
  private var orchestrationTask: Task<Void, Never>?
  
  private var statesContinuation: AsyncStream<TrainingState>.Continuation
  public let states: AsyncStream<TrainingState>
  
  public init(
    initialState: TrainingState = TrainingState(),
    engine: TrainingEngine,
    strategy: QuestionStrategy,
    audioPlayer: AudioPlaying,
    timing: TrainingTiming = .default
  ) {
    self.state = initialState
    
    var tempContinuation: AsyncStream<TrainingState>.Continuation!
    
    self.states = AsyncStream { continuation in
      tempContinuation = continuation
    }
    
    self.statesContinuation = tempContinuation
    self.engine = engine
    self.strategy = strategy
    self.audioPlayer = audioPlayer
    self.timing = timing
  }
  
  deinit {
    statesContinuation.finish()
    orchestrationTask?.cancel()
  }
  
  public func dispatch(_ action: TrainingAction) async {
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
  
  private func cleanupAfterCancellation() {
    guard state.phase == .resolvingAnswer else { return }
    
    state = engine.reduce(state: state, action: .retryCurrentQuestion).state
    statesContinuation.yield(state)
  }
  
  private func handle(_ events: [TrainingEvent]) async throws {
    for event in events {
      switch event {
        
      case .answeredCorrect:
        let nextQuestion = strategy.nextQuestion(from: state)
        
        try await Task.sleep(nanoseconds: timing.correctNextDelay)
        try Task.checkCancellation()
        
        state = engine.reduce(state: state, action: .next(nextQuestion)).state
        statesContinuation.yield(state)
        
        await playCurrent()
        
      case .answeredWrong:
        try await Task.sleep(nanoseconds: timing.wrongReplayDelay)
        try Task.checkCancellation()
        
        state = engine.reduce(state: state, action: .retryCurrentQuestion).state
        statesContinuation.yield(state)
        
        await playCurrent()
        
      case .sessionStarted:
        let firstQuestion = strategy.nextQuestion(from: state)
        
        state = engine.reduce(state: state, action: .next(firstQuestion)).state
        statesContinuation.yield(state)
        
        try await Task.sleep(nanoseconds: timing.initialPlayDelay)
        try Task.checkCancellation()
        
        await playCurrent()
      }
    }
  }
  
  private func playCurrent() async {
    guard let question = state.currentQuestion else { return }
    try? await audioPlayer.play(resourceName: question.audioResourceName)
  }
  
}
