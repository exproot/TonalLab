//
//  QuestionSelecting.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import Foundation

public protocol QuestionSelecting: Sendable {
  func nextQuestion(context: TrainingContext) -> PitchClass
}
