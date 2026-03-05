//
//  EarTrainingEngine.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import Foundation

protocol ModeReducer {
  func reduce(state: EarTrainingState, action: EarTrainingAction) -> ReductionResult
}

struct PracticeReducer: ModeReducer {
  
  func reduce(state: EarTrainingState, action: EarTrainingAction) -> ReductionResult {
    
    switch action {
      
    case .start:
      return ReductionResult(
        state: state.updating(
          score: 0,
          lastResult: nil,
          remainingQuestions: nil,
          remainingLives: nil,
          remainingReplays: nil
        ),
        events: [.sessionStarted]
      )
      
    case .submit(let answer):
      guard
        let question = state.currentQuestion,
        state.phase == .waitingForAnswer
      else {
        return ReductionResult(state: state, events: [])
      }
      
      let isCorrect = answer == question.pitchClass
      
      let event: EarTrainingEvent = isCorrect
      ? .answeredCorrect(question)
      : .answeredWrong(question)
      
      return ReductionResult(
        state: state.updating(
          currentQuestion: question,
          score: isCorrect ? state.score + 1 : state.score,
          lastResult: isCorrect,
          phase: .resolvingAnswer
        ),
        events: [event]
      )
      
    case .next(let nextQuestion), .begin(let nextQuestion):
      return ReductionResult(
        state: state.updating(
          currentQuestion: nextQuestion,
          lastResult: nil,
          phase: .waitingForAnswer
        ),
        events: []
      )
      
    case .retryCurrentQuestion:
      guard let currentQuestion = state.currentQuestion else {
        return ReductionResult(state: state, events: [])
      }
      
      let refreshed = EarTrainingQuestion(pitchClass: currentQuestion.pitchClass)
      
      return ReductionResult(
        state: state.updating(
          currentQuestion: refreshed,
          lastResult: nil,
          phase: .waitingForAnswer
        ),
        events: []
      )
      
    case .replayAudio:
      return ReductionResult(state: state, events: [.audioReplayRequested])
      
    }
    
  }
  
}

struct GameReducer: ModeReducer {
  
  let totalQuestions: Int
  let totalLives: Int
  let totalAudioReplays: Int
  
  init(totalQuestions: Int, totalLives: Int, totalAudioReplays: Int) {
    self.totalQuestions = totalQuestions
    self.totalLives = totalLives
    self.totalAudioReplays = totalAudioReplays
  }
  
  func reduce(state: EarTrainingState, action: EarTrainingAction) -> ReductionResult {
    
    switch action {
      
    case .start:
      return ReductionResult(
        state: state.updating(
          score: 0,
          lastResult: nil,
          phase: .idle,
          remainingQuestions: totalQuestions,
          remainingLives: totalLives,
          remainingReplays: totalAudioReplays
        ),
        events: [.sessionStarted]
      )
      
    case .submit(let answer):
      guard
        let question = state.currentQuestion,
        state.phase == .waitingForAnswer
      else {
        return ReductionResult(state: state, events: [])
      }
      
      let isCorrect = answer == question.pitchClass
      
      guard let lives = state.remainingLives else {
        return ReductionResult(state: state, events: [])
      }
      
      let updatedLives = isCorrect ? lives : lives - 1
      
      if !isCorrect && updatedLives <= 0 {
        let result = EarTrainingResult(
          score: state.score,
          totalQuestions: totalQuestions,
          totalLives: totalLives,
          totalReplays: totalAudioReplays,
          livesLeft: updatedLives,
          replaysUsed: totalAudioReplays - (state.remainingReplays ?? 0)
        )
        
        return ReductionResult(
          state: state.updating(phase: .finished(result)),
          events: []
        )
      }
      
      let event: EarTrainingEvent = isCorrect
      ? .answeredCorrect(question)
      : .answeredWrong(question)
      
      return ReductionResult(
        state: state.updating(
          currentQuestion: question,
          score: isCorrect ? state.score + 1 : state.score,
          lastResult: isCorrect,
          phase: .resolvingAnswer,
          remainingLives: updatedLives
        ),
        events: [event]
      )
      
    case .next(let nextQuestion):
      guard let questions = state.remainingQuestions else {
        return ReductionResult(state: state, events: [])
      }
      
      let updatedQuestions = questions - 1
      
      if updatedQuestions <= 0 {
        let result = EarTrainingResult(
          score: state.score,
          totalQuestions: totalQuestions,
          totalLives: totalLives,
          totalReplays: totalAudioReplays,
          livesLeft: state.remainingLives ?? 0,
          replaysUsed: totalAudioReplays - (state.remainingReplays ?? 0)
        )
        
        return ReductionResult(
          state: state.updating(phase: .finished(result)),
          events: []
        )
      }
      
      return ReductionResult(
        state: state.updating(
          currentQuestion: nextQuestion,
          lastResult: nil,
          phase: .waitingForAnswer,
          remainingQuestions: updatedQuestions
        ),
        events: []
      )
      
    case .begin(let question):
      return ReductionResult(
        state: state.updating(
          currentQuestion: question,
          lastResult: nil,
          phase: .waitingForAnswer
        ),
        events: []
      )
      
    case .retryCurrentQuestion:
      return ReductionResult(state: state, events: [])
      
    case .replayAudio:
      guard
        let replays = state.remainingReplays,
        replays > 0,
        state.phase == .waitingForAnswer
      else {
        return ReductionResult(state: state, events: [])
      }
      
      return ReductionResult(
        state: state.updating(remainingReplays: replays - 1),
        events: [.audioReplayRequested]
      )
    }
  }
  
}

public struct EarTrainingEngine {
  
  let reducer: ModeReducer
  
  public init(context: EarTrainingContext) {
    switch context.mode {
    case .practice:
      reducer = PracticeReducer()
      
    case .game(let totalQuestions, let totalLives , let totalAudioReplays):
      reducer = GameReducer(
        totalQuestions: totalQuestions,
        totalLives: totalLives,
        totalAudioReplays: totalAudioReplays
      )
    }
  }
  
  public func reduce(state: EarTrainingState, action: EarTrainingAction) -> ReductionResult {
    reducer.reduce(state: state, action: action)
  }
  
}


