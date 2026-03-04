//
//  EarTrainingTiming.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import Foundation

public struct EarTrainingTiming: Sendable {
  public let initialPlayDelay: UInt64
  public let correctNextDelay: UInt64
  public let wrongReplayDelay: UInt64
  
  public init(
    initialPlayDelay: UInt64,
    correctNextDelay: UInt64,
    wrongReplayDelay: UInt64
  ) {
    self.initialPlayDelay = initialPlayDelay
    self.correctNextDelay = correctNextDelay
    self.wrongReplayDelay = wrongReplayDelay
  }
  
  public static let `default` = EarTrainingTiming(
    initialPlayDelay: 300_000_000,
    correctNextDelay: 500_000_000,
    wrongReplayDelay: 500_000_000
  )
}
