//
//  EarTrainingViewModel.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import Combine
import Foundation
import EarTrainingDomain

struct EarTrainingViewModelActions {
  let showResult: (EarTrainingResult) -> Void
}

enum EarTrainingModeBadgeTint {
  case practice, game
}

struct PracticeHeaderUIModel: Equatable {
  let modeBadge: EarTrainingModeBadgeUIModel
  let score: Int
}

struct GameHeaderUIModel: Equatable {
  let modeBadge: EarTrainingModeBadgeUIModel
  let remainingQuestions: Int
  let totalQuestions: Int
  let remainingLives: Int
  let totalLives: Int
  let remainingReplays: Int
  let totalReplays: Int
  let score: Int
}

enum EarTrainingHeaderUIModel: Equatable {
  case practice(PracticeHeaderUIModel)
  case game(GameHeaderUIModel)
}

struct EarTrainingModeBadgeUIModel: Equatable {
  let title: String
  let systemImage: String
  let tint: EarTrainingModeBadgeTint
}

@MainActor
final class EarTrainingViewModel: ObservableObject {
  
  // MARK: Dependencies
  private let session: EarTrainingSessionProtocol
  private let actions: EarTrainingViewModelActions
  
  private var listenTask: Task<Void, Never>?
  
  // MARK: Output
  @Published private(set) var state: EarTrainingState
  @Published private(set) var selectedNote: PitchClass?
  @Published private(set) var headerUIModel: EarTrainingHeaderUIModel
  
  // MARK: Lifecycle
  init(
    session: EarTrainingSessionProtocol,
    actions: EarTrainingViewModelActions
  ) {
    self.session = session
    self.actions = actions
    self.state = EarTrainingState(context: EarTrainingContext(mode: .practice))
    self.headerUIModel = .practice(
      PracticeHeaderUIModel(
        modeBadge: .init(title: "PRACTICE", systemImage: "infinity", tint: .practice),
        score: 0
      )
    )
    
    startListening()
    bindDerivedState()
  }
  
  deinit {
    listenTask?.cancel()
  }
  
  // MARK: Computed
  var canAnswerQuestion: Bool { state.phase == .waitingForAnswer }
  var canReplay: Bool {
    guard let replays = state.remainingReplays else { return false }
    
    return canAnswerQuestion && replays > 0
  }
  
  // MARK: Public
  func start() async {
    await session.dispatch(.start)
  }
  
  func submit(_ answer: PitchClass) {
    guard canAnswerQuestion else { return }
    
    selectedNote = answer
    Task { await session.dispatch(.submit(answer)) }
  }
  
  func replay() {
    guard canReplay else { return }
    
    Task { await session.dispatch(.replayAudio) }
  }
  
  func stop() {
    listenTask?.cancel()
    listenTask = nil
  }
  
  // MARK: Private
  private func bindDerivedState() {
    $state
      .map { Self.makeHeaderUIModel(from: $0) }
      .removeDuplicates()
      .receive(on: DispatchQueue.main)
      .assign(to: &$headerUIModel)
  }
  
  private func startListening() {
    let session = self.session
    let actions = self.actions
    
    listenTask = Task { [weak self] in
      for await newState in session.states {
        guard !Task.isCancelled else { break }
        self?.consume(newState, actions: actions)
      }
    }
  }
  
  private func consume(_ newState: EarTrainingState, actions: EarTrainingViewModelActions) {
    let oldID = state.currentQuestion?.id
    let newID = newState.currentQuestion?.id
    
    state = newState
    
    if oldID != newID {
      selectedNote = nil
    }
    
    if case let .finished(result) = newState.phase {
      actions.showResult(result)
    }
  }
  
}

extension EarTrainingViewModel {
  var phaseImageString: String {
    switch state.phase {
    case .idle, .finished:
      "magnifyingglass"
    case .waitingForAnswer:
      "ear.badge.waveform"
    case .resolvingAnswer:
      "hourglass.bottomhalf.filled"
    }
  }
  
  var phaseText: String {
    switch state.phase {
    case .idle, .finished:
      "Waiting"
    case .waitingForAnswer:
      "Listen and choose the correct note"
    case .resolvingAnswer:
      "Checking your answer"
    }
  }
}

extension EarTrainingViewModel {
  private static func makeHeaderUIModel(from state: EarTrainingState) -> EarTrainingHeaderUIModel {
    switch state.context.mode {
    case .practice:
      return .practice(
        PracticeHeaderUIModel(
          modeBadge: makeBadge(from: state.context.mode),
          score: state.score
        )
      )
      
    case .game(let totalQuestions, let totalLives, let totalAudioReplays):
      guard
        let remainingQuestions = state.remainingQuestions,
        let remainingLives = state.remainingLives,
        let remainingReplays = state.remainingReplays
      else {
        return .game(
          GameHeaderUIModel(
            modeBadge: makeBadge(from: state.context.mode),
            remainingQuestions: totalQuestions,
            totalQuestions: totalQuestions,
            remainingLives: totalLives,
            totalLives: totalLives,
            remainingReplays: totalAudioReplays,
            totalReplays: totalAudioReplays,
            score: state.score
          )
        )
      }
      
      return .game(
        GameHeaderUIModel(
          modeBadge: makeBadge(from: state.context.mode),
          remainingQuestions: remainingQuestions,
          totalQuestions: totalQuestions,
          remainingLives: remainingLives,
          totalLives: totalLives,
          remainingReplays: remainingReplays,
          totalReplays: totalAudioReplays,
          score: state.score
        )
      )
    }
  }
  
  private static func makeBadge(from mode: EarTrainingMode) -> EarTrainingModeBadgeUIModel {
    switch mode {
    case .practice:
      return EarTrainingModeBadgeUIModel(
        title: "PRACTICE",
        systemImage: "infinity",
        tint: .practice
      )
      
    case .game:
      return EarTrainingModeBadgeUIModel(
        title: "GAME",
        systemImage: "flag.checkered",
        tint: .game
      )
    }
  }
}
