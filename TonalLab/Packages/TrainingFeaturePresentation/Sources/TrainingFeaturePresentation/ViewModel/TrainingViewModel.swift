//
//  TrainingViewModel.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import Combine
import TrainingFeatureDomain

@MainActor
final class TrainingViewModel: ObservableObject {
  
  private let session: TrainingSession
  private var listenTask: Task<Void, Never>?
  
  @Published private(set) var state = TrainingState()
  
  init(session: TrainingSession) {
    self.session = session
    startListening()
  }
  
  deinit {
    listenTask?.cancel()
  }
  
  var canAnswerQuestion: Bool { state.phase == .waitingForAnswer }
  
  func start() async {
    await session.dispatch(.start)
  }
  
  func submit(_ answer: PitchClass) {
    Task { await session.dispatch(.submit(answer)) }
  }
  
  private func startListening() {
    listenTask = Task {
      for await newState in await session.states {
        self.state = newState
      }
    }
  }
  
}
