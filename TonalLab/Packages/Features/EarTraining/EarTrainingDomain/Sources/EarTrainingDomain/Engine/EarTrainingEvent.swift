//
//  EarTrainingEvent.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 23.02.2026.
//

import Foundation

public enum EarTrainingEvent: Sendable {
  case answeredCorrect(EarTrainingQuestion)
  case answeredWrong(EarTrainingQuestion)
  case sessionStarted
  case audioReplayRequested
}
