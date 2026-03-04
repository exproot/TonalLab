//
//  EarTrainingState.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import Foundation

public struct EarTrainingState: Equatable, Sendable {
  
  public let currentQuestion: EarTrainingQuestion?
  public let score: Int
  public let lastResult: Bool?
  public let phase: Phase
  public let remainingQuestions: Int?
  public let remainingLives: Int?
  public let remainingReplays: Int?
  public let context: EarTrainingContext
  
  public init(
    currentQuestion: EarTrainingQuestion? = nil,
    score: Int = 0,
    lastResult: Bool? = nil,
    phase: Phase = .idle,
    remainingQuestions: Int? = nil,
    remainingLives: Int? = nil,
    remainingReplays: Int? = nil,
    context: EarTrainingContext
  ) {
    self.currentQuestion = currentQuestion
    self.score = score
    self.lastResult = lastResult
    self.phase = phase
    self.remainingQuestions = remainingQuestions
    self.remainingLives = remainingLives
    self.remainingReplays = remainingReplays
    self.context = context
  }
  
}

extension EarTrainingState {
  func updating(
    currentQuestion: EarTrainingQuestion? = nil,
    score: Int? = nil,
    lastResult: Bool? = nil,
    phase: Phase? = nil,
    remainingQuestions: Int? = nil,
    remainingLives: Int? = nil,
    remainingReplays: Int? = nil
  ) -> EarTrainingState {
    .init(
      currentQuestion: currentQuestion ?? self.currentQuestion,
      score: score ?? self.score,
      lastResult: lastResult ?? self.lastResult,
      phase: phase ?? self.phase,
      remainingQuestions: remainingQuestions ?? self.remainingQuestions,
      remainingLives: remainingLives ?? self.remainingLives,
      remainingReplays: remainingReplays ?? self.remainingReplays,
      context: self.context
    )
  }
}
