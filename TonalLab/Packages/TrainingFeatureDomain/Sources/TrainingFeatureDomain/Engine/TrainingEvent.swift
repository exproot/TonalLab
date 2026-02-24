//
//  TrainingEvent.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 23.02.2026.
//

import Foundation

public enum TrainingEvent: Sendable {
  case answeredCorrect(PitchClass)
  case answeredWrong(PitchClass)
  case sessionStarted
}
