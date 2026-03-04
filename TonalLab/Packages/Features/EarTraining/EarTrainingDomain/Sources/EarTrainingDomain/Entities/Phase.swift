//
//  Phase.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 23.02.2026.
//

import Foundation

public enum Phase: Equatable, Sendable {
  case idle
  case waitingForAnswer
  case resolvingAnswer
  case finished(score: Int, totalQuestions: Int)
}
