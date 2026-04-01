//
//  GameHeaderView.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import SharedUI
import SwiftUI

struct GameHeaderView: View {
  
  @Environment(\.theme) private var theme
  
  let model: GameHeaderUIModel
  
  private var answeredQuestions: Int {
    max(0, model.totalQuestions - model.remainingQuestions)
  }
  
  private var currentQuestionNumber: Int {
    model.remainingQuestions > 0
    ? min(model.totalQuestions, answeredQuestions + 1)
    : model.totalQuestions
  }
  
  private var progress: Double {
    Double(min(answeredQuestions, model.totalQuestions)) / Double(model.totalQuestions)
  }
  
  var body: some View {
    VStack(spacing: Spacing.medium) {
      
      HStack {
        ModeBadgeView(model: model.modeBadge)
        
        Spacer()
        
        Text("Question \(currentQuestionNumber) / \(model.totalQuestions)")
          .font(Typography.subtitle)
          .fontWeight(.semibold)
          .padding(.horizontal, Insets.chipHorizontal)
          .padding(.vertical, Insets.chipVertical)
      }
      
      ProgressView(value: progress)
      
      HStack {
        livesView
        Spacer()
        replaysView
        scoreView
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      .background(.ultraThinMaterial)
      .clipShape(RoundedRectangle(cornerRadius: Radius.large))
      .overlay(
        RoundedRectangle(cornerRadius: Radius.large)
          .strokeBorder(.separator.opacity(0.5), lineWidth: 1)
      )
    }
  }
  
  private var livesView: some View {
    CapsuleChip {
      HStack(spacing: Spacing.small) {
        ForEach(0..<model.totalLives, id: \.self) { i in
          Image(
            systemName: i < model.remainingLives
            ? "heart.fill"
            : "heart"
          )
          .symbolRenderingMode(.hierarchical)
          .foregroundStyle(
            i < model.remainingLives
            ? theme.colors.palette.brandSecondary
            : theme.colors.secondary
          )
          .animation(AppAnimation.spring, value: model.remainingLives)
        }
      }
    }
  }
  
  private var replaysView: some View {
    CapsuleChip {
      HStack(spacing: Spacing.extraSmall) {
        Image(systemName: "speaker.wave.2.fill")
        
        Text("\(model.remainingReplays) / \(model.totalReplays)")
      }
    }
  }
  
  private var scoreView: some View {
    CapsuleChip {
      HStack(spacing: Spacing.small) {
        Image(systemName: "trophy.fill")
          .foregroundStyle(theme.colors.palette.accentSecondary)
        
        Text("\(model.score)")
          .font(Typography.subtitle)
          .fontWeight(.semibold)
      }
    }
  }
  
}

#Preview {
  GameHeaderView(
    model:
      GameHeaderUIModel(
        modeBadge: .init(title: "PRACTICE", systemImage: "infinity", tint: .practice),
        remainingQuestions: 10,
        totalQuestions: 10,
        remainingLives: 3,
        totalLives: 3,
        remainingReplays: 3,
        totalReplays: 3,
        score: 5
      )
  )
}
