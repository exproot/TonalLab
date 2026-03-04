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
  
  public func nextQuestion(from state: EarTrainingState) -> EarTrainingQuestion {
    let note = selector.nextQuestion(context: state.context)
    
    return EarTrainingQuestion(pitchClass: note)
  }
  
}
