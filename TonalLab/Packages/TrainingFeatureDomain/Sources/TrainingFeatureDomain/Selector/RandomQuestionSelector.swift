//
//  RandomQuestionSelector.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import Foundation

public struct RandomQuestionSelector: QuestionSelecting {
  
  private let scale: Scale
  
  public init(scale: Scale) {
    self.scale = scale
  }
  
  public func nextQuestion(context: TrainingContext) -> PitchClass {
    scale.notes.randomElement()!
  }
  
}
