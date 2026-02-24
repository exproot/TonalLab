//
//  TrainingAction.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import Foundation

public enum TrainingAction: Sendable {
  case start
  case submit(PitchClass)
  case retryCurrentQuestion
  case next(PitchClass)
}
