//
//  TrainingContext.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import Foundation

public struct TrainingContext: Sendable, Equatable {
  
  public let weakNotes: [PitchClass]
  public let seed: UInt64
  
  public init(weakNotes: [PitchClass], seed: UInt64) {
    self.weakNotes = weakNotes
    self.seed = seed
  }
  
  public static let `default` = TrainingContext(
    weakNotes: [],
    seed: 0
  )
  
}
