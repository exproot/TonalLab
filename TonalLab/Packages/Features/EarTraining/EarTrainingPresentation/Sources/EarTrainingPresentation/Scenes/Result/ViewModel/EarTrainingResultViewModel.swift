//
//  EarTrainingResultViewModel.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 5.03.2026.
//

import EarTrainingDomain
import Foundation

struct EarTrainingResultViewModelActions {
  let onTappingBack: () -> Void
}

@MainActor
final class EarTrainingResultViewModel: ObservableObject {
  
  enum RingTone {
    case excellent, good, fair, poor
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
    let ringColor: RingTone
    let ringGlowOpacity: Double
    let stats: [ResultStat]
    let primaryButtonTitle: String
  }
  
  // MARK: Dependencies
  private let result: EarTrainingResult
  private let actions: EarTrainingResultViewModelActions
  
  // MARK: Output
  @Published private(set) var uiModel: UIModel
  
  // MARK: Lifecycle
  init(
    result: EarTrainingResult,
    actions: EarTrainingResultViewModelActions
  ) {
    self.result = result
    self.actions = actions
    
    uiModel = EarTrainingResultUIMapper.map(result)
  }
  
  // MARK: Computed
  var shouldShowConfetti: Bool {
    uiModel.progress >= 0.7
  }
  
  var finalScore: Int {
    Int(uiModel.progress * Double(result.totalQuestions))
  }
  
  func didTapBack() {
    actions.onTappingBack()
  }
  
}
