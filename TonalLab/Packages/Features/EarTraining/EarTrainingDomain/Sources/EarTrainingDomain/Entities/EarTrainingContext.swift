//
//  EarTrainingContext.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import Foundation

public struct EarTrainingContext: Sendable, Equatable {
  
  public let mode: EarTrainingMode
  
  public init(mode: EarTrainingMode) {
    self.mode = mode
  }
  
}
