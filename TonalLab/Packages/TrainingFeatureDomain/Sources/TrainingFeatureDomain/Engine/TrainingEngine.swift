//
//  TrainingEngine.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import Foundation

public struct TrainingEngine {
  
  public init() { }
  
  public func reduce(
    state: TrainingState,
    action: TrainingAction
  ) -> ReductionResult {
    switch action {
      
    case .start:
      let newState = TrainingState(
        currentQuestion: state.currentQuestion,
        score: 0,
        lastResult: nil,
        phase: .idle,
        context: state.context
      )
      
      return ReductionResult(state: newState, events: [.sessionStarted])
      
    case .submit(let answer):
      guard
        let question = state.currentQuestion,
        state.phase == .waitingForAnswer
      else {
        return ReductionResult(state: state, events: [])
      }
      
      let isCorrect = answer == question
      
      let newState = TrainingState(
        currentQuestion: question,
        score: isCorrect ? state.score + 1 : state.score,
        lastResult: isCorrect,
        phase: .resolvingAnswer,
        context: state.context
      )
      
      let event: TrainingEvent = isCorrect
      ? .answeredCorrect(question)
      : .answeredWrong(question)
      
      return ReductionResult(state: newState, events: [event])
      
    case .next(let nextQuestion):
      let newState = TrainingState(
        currentQuestion: nextQuestion,
        score: state.score,
        lastResult: nil,
        phase: .waitingForAnswer,
        context: state.context
      )
      
      return ReductionResult(state: newState, events: [])
      
    case .retryCurrentQuestion:
      let newState = TrainingState(
        currentQuestion: state.currentQuestion,
        score: state.score,
        lastResult: nil,
        phase: .waitingForAnswer,
        context: state.context
      )
      
      return ReductionResult(state: newState, events: [])
    }
  
  }
  
}
