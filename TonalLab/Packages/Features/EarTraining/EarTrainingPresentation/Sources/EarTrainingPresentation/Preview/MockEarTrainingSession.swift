//
//  MockEarTrainingSession.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 25.02.2026.
//

import EarTrainingDomain

actor MockEarTrainingSession: EarTrainingSessionProtocol {
  
  let states: AsyncStream<EarTrainingState>
  
  private let continuation: AsyncStream<EarTrainingState>.Continuation
  
  init(mockState: EarTrainingState) {
    var cont: AsyncStream<EarTrainingState>.Continuation!
    
    self.states = AsyncStream { cont = $0 }
    self.continuation = cont
    
    continuation.yield(mockState)
  }
  
  func dispatch(_ action: EarTrainingAction) async {
  }
  
}
