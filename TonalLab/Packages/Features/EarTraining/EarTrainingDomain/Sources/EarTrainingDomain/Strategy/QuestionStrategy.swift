//
//  QuestionStrategy.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 22.02.2026.
//

import Foundation

public protocol QuestionStrategy: Sendable {
  func nextQuestion(from state: EarTrainingState) -> EarTrainingQuestion
}
