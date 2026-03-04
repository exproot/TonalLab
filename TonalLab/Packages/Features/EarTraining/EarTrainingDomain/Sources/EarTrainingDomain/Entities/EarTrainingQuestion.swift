//
//  EarTrainingQuestion.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 3.03.2026.
//

import Foundation

public struct EarTrainingQuestion: Equatable, Sendable {
  
  public let id: UUID
  public let pitchClass: PitchClass
  
  public init(id: UUID = UUID(), pitchClass: PitchClass) {
    self.id = id
    self.pitchClass = pitchClass
  }
  
}
