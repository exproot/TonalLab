//
//  EarTrainingResultUIMapper.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 5.03.2026.
//

import EarTrainingDomain
import Foundation

enum EarTrainingResultUIMapper {
  
  static func map(_ result: EarTrainingResult) -> EarTrainingResultViewModel.UIModel {
    let progress = result.totalQuestions > 0
    ? Double(result.score) / Double(result.totalQuestions)
    : 0
    
    let grade = makeGrade(progress: progress)
    let ringColor = makeRingColor(progress: progress)
    let glow = makeGlowOpacity(progress: progress)
    
    let stats: [EarTrainingResultViewModel.ResultStat] = [
      .init(
        title: "Lives Left",
        value: "\(result.livesLeft)/\(result.totalLives)",
        type: .lives
      ),
      .init(
        title: "Replays Used",
        value: "\(result.replaysUsed)/\(result.totalReplays)",
        type: .replays
      )
    ]
    
    return .init(
      title: "Round Complete",
      subtitle: "Nice work - keep training!",
      totalQuestions: result.totalQuestions,
      scoreText: "\(result.score) / \(result.totalQuestions)",
      gradeText: grade,
      progress: progress,
      ringColor: ringColor,
      ringGlowOpacity: glow,
      stats: stats,
      primaryButtonTitle: "Back to Home"
    )
  }
  
}

private extension EarTrainingResultUIMapper {
  
  static func makeGrade(progress: Double) -> String {
    switch progress {
    case 0.9...1: return "S"
    case 0.8..<0.9: return "A"
    case 0.65..<0.8: return "B"
    case 0.5..<0.65: return "C"
    default: return "D"
    }
  }
  
  static func makeRingColor(progress: Double) -> EarTrainingResultViewModel.RingTone {
    switch progress {
    case 0.85...: return .excellent
    case 0.7..<0.85: return .good
    case 0.5..<0.7: return .fair
    default: return .poor
    }
  }
  
  static func makeGlowOpacity(progress: Double) -> Double {
    switch progress {
    case 0.85...: return 0.35
    case 0.7..<0.85: return 0.28
    case 0.5..<0.7: return 0.22
    default: return 0.18
    }
  }
  
}
