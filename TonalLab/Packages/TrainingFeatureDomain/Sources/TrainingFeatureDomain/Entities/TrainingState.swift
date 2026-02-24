//
//  TrainingState.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import Foundation

public struct TrainingState: Equatable, Sendable {
  
  public let currentQuestion: PitchClass?
  public let score: Int
  public let lastResult: Bool?
  public let phase: Phase
  public let context: TrainingContext
  
  public init(
    currentQuestion: PitchClass? = nil,
    score: Int = 0,
    lastResult: Bool? = nil,
    phase: Phase = .idle,
    context: TrainingContext = .default
  ) {
    self.currentQuestion = currentQuestion
    self.score = score
    self.lastResult = lastResult
    self.phase = phase
    self.context = context
  }
  
}
