//
//  EarTrainingMode.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 28.02.2026.
//

import Foundation

public enum EarTrainingMode: Equatable, Sendable {
  case practice
  case game(totalQuestions: Int, totalLives: Int, totalAudioReplays: Int)
}
