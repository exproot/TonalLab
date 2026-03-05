//
//  EarTrainingResult.swift
//  EarTrainingDomain
//
//  Created by Ertan Yağmur on 5.03.2026.
//

import Foundation

public struct EarTrainingResult: Equatable, Sendable {
  
  public let score: Int
  public let totalQuestions: Int
  public let totalLives: Int
  public let totalReplays: Int
  public let livesLeft: Int
  public let replaysUsed: Int
  
  public init(
    score: Int,
    totalQuestions: Int,
    totalLives: Int,
    totalReplays: Int,
    livesLeft: Int,
    replaysUsed: Int
  ) {
    self.score = score
    self.totalQuestions = totalQuestions
    self.totalLives = totalLives
    self.totalReplays = totalReplays
    self.livesLeft = livesLeft
    self.replaysUsed = replaysUsed
  }
  
}
