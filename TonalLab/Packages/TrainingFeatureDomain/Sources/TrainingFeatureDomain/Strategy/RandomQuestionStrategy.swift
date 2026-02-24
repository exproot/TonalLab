//
//  RandomQuestionStrategy.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 22.02.2026.
//

import Foundation

public struct RandomQuestionStrategy: QuestionStrategy {
  
  private let selector: QuestionSelecting
  
  public init(selector: QuestionSelecting) {
    self.selector = selector
  }
  
  public func nextQuestion(from state: TrainingState) -> PitchClass {
    selector.nextQuestion(context: state.context)
  }
  
}
