//
//  EarTrainingAction.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import Foundation

public enum EarTrainingAction: Sendable {
  case next(EarTrainingQuestion)
  case begin(EarTrainingQuestion)
  case submit(PitchClass)
  case retryCurrentQuestion
  case replayAudio
  case start

}
