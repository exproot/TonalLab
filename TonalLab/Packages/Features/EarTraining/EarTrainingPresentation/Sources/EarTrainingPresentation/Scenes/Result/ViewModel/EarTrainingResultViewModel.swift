//
//  EarTrainingResultViewModel.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 5.03.2026.
//

import EarTrainingDomain
import Foundation

@MainActor
final class EarTrainingResultViewModel: ObservableObject {
  
  enum RingColor {
    case green, yellow, orange, red
  }
  
  struct ResultStat: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let value: String
    let type: StatType
    
    enum StatType {
      case lives
      case replays
    }
  }
  
  struct UIModel: Equatable {
    let title: String
    let subtitle: String
    let totalQuestions: Int
    let scoreText: String
    let gradeText: String
    let progress: Double
    let ringColor: RingColor
    let ringGlowOpacity: Double
    let stats: [ResultStat]
    let primaryButtonTitle: String
    let secondaryButtonTitle: String
  }
  
  // MARK: Dependencies
  private let result: EarTrainingResult
  
  // MARK: Output
  @Published private(set) var uiModel: UIModel
  
  // MARK: Lifecycle
  init(result: EarTrainingResult) {
    self.result = result
    self.uiModel = EarTrainingResultUIMapper.map(result)
  }
  
  // MARK: Computed
  var shouldShowConfetti: Bool {
    uiModel.progress >= 0.7
  }
  
  var finalScore: Int {
    Int(uiModel.progress * Double(result.totalQuestions))
  }
  
}
