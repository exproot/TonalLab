//
//  EarTrainingResultViewModel.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 5.03.2026.
//

import Foundation

@MainActor
final class EarTrainingResultViewModel: ObservableObject {
  
  struct UIModel: Equatable {
    let title: String
    let subtitle: String
    let scoreText: String
    let gradeText: String
    let progress: Double
    let primaryButtonTitle: String
    let secondaryButtonTitle: String
  }
  
  @Published private(set) var uiModel: UIModel
  
  init(score: Int, totalQuestions: Int) {
    let progress = totalQuestions > 0
    ? Double(score) / Double(totalQuestions)
    : 0
    
    self.uiModel = UIModel(
      title: "Round Complete",
      subtitle: "Nice work - keep training!",
      scoreText: "\(score) / \(totalQuestions)",
      gradeText: Self.makeGrade(progress: progress),
      progress: progress,
      primaryButtonTitle: "Play Again",
      secondaryButtonTitle: "Practice"
    )
  }
  
  private static func makeGrade(progress: Double) -> String {
    switch progress {
    case 0.9...1: return "S"
    case 0.8..<0.9: return "A"
    case 0.65..<0.8: return "B"
    case 0.5..<0.65: return "C"
    default: return "D"
    }
  }
  
}
