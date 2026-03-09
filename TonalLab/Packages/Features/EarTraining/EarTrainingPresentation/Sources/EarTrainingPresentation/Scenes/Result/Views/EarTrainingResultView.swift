//
//  EarTrainingResultView.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 5.03.2026.
//

import EarTrainingDomain
import DotLottie
import SharedUI
import SwiftUI

struct EarTrainingResultView: View {
  
  @Environment(\.theme) private var theme
  
  @ObservedObject var viewModel: EarTrainingResultViewModel
  
  @State private var animatedProgress: Double = 0
  @State private var displayedScore = 0
  @State private var showConfetti = false
  
  let confettiAnimation = DotLottieAnimation(
    fileName: "confetti",
    bundle: .module,
    config: .init()
  )
  
  var body: some View {
    ScreenContainer {
      VStack(spacing: Spacing.large) {
        VStack(spacing: Spacing.small) {
          Text(viewModel.uiModel.title)
            .font(Typography.title)
          
          Text(viewModel.uiModel.subtitle)
            .font(Typography.subtitle)
            .foregroundStyle(.secondary)
        }
        
        ZStack {
          
          if showConfetti {
            DotLottiePlayerView(animation: confettiAnimation)
              .playing()
              .allowsHitTesting(false)
              .frame(height: 220)
          }
          
          scoreRing
        }
        
        statsSection
        actionButtons
        
        Spacer(minLength: 0)
      }
    }
    .task(id: viewModel.finalScore) {
      displayedScore = 0
      animatedProgress = 0
    
      async let scoreTask: () = animateScore()
      
      withAnimation(.easeInOut(duration: 0.6)) {
        animatedProgress = viewModel.uiModel.progress
      }
      
      await scoreTask
      
      showConfetti = viewModel.shouldShowConfetti
    }
  }
  
  private var scoreRing: some View {
    VStack(spacing: Spacing.large) {
      ZStack {
        Circle()
          .stroke(.gray.opacity(0.18), lineWidth: 14)
        
        Circle()
          .trim(from: 0, to: animatedProgress)
          .stroke(
            ringColor,
            style: StrokeStyle(lineWidth: 14, lineCap: .round)
          )
          .shadow(
            color: ringColor.opacity(viewModel.uiModel.ringGlowOpacity),
            radius: 10,
            y: 6
          )
          .rotationEffect(.degrees(-90))
        
        VStack(spacing: Spacing.small) {
          Text("\(displayedScore) / \(viewModel.uiModel.totalQuestions)")
            .font(Typography.digit)
          
          Text("Grade: \(viewModel.uiModel.gradeText)")
            .font(Typography.subtitle)
            .fontWeight(.semibold)
            .foregroundStyle(theme.colors.secondary)
        }
      }
      .frame(width: 180, height: 180)
      
      CapsuleChip {
        HStack(spacing: Spacing.small) {
          Image(systemName: "sparkles")
          
          Text("Accuracy \(Int(viewModel.uiModel.progress * 100))%")
            .monospacedDigit()
        }
        .font(Typography.subtitle)
        .fontWeight(.semibold)
      }
    }
    .padding(.top, 10)
  }
  
  private var actionButtons: some View {
    VStack(spacing: Spacing.medium) {
      Button {
        // TODO: Play again
      } label: {
        Text(viewModel.uiModel.primaryButtonTitle)
      }
      .buttonStyle(PrimaryButtonStyle())
      
      Button {
        // TODO: Practice
      } label: {
        Text(viewModel.uiModel.secondaryButtonTitle)
      }
      .buttonStyle(
        PrimaryButtonStyle(
          backgroundColor: theme.colors.secondary.opacity(0.18),
          foregroundColor: theme.colors.primary
        )
      )
    }
    .font(.headline)
    .padding(.top, 8)
  }
  
  private var statsSection: some View {
    HStack(spacing: Spacing.medium) {
      ForEach(viewModel.uiModel.stats) { stat in
        statCard(stat)
      }
    }
  }
  
  private var ringColor: Color {
    switch viewModel.uiModel.ringColor {
    case .excellent: theme.colors.semantic.success
    case .good: theme.colors.semantic.info
    case .fair: theme.colors.semantic.warning
    case .poor: theme.colors.semantic.error
    }
  }
  
  private func statCard(_ stat: EarTrainingResultViewModel.ResultStat) -> some View {
    VStack(spacing: Spacing.small) {
      Image(systemName: iconName(for: stat.type))
        .frame(width: IconSize.medium, height: IconSize.medium)
        .foregroundStyle(iconColor(for: stat.type))
      
      Text(stat.title)
        .font(Typography.caption)
        .foregroundStyle(theme.colors.secondary)
      
      Text(stat.value)
        .font(.headline)
        .monospacedDigit()
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 12)
    .background(CardBackground())
  }
  
  private func iconName(for type: EarTrainingResultViewModel.ResultStat.StatType) -> String {
    switch type {
    case .lives: return "heart.fill"
    case .replays: return "speaker.wave.2.fill"
    }
  }
  
  private func iconColor(for type: EarTrainingResultViewModel.ResultStat.StatType) -> Color {
    switch type {
    case .lives: return theme.colors.palette.brandSecondary
    case .replays: return theme.colors.primary
    }
  }
  
  private func animateScore() async {
    let finalScore = viewModel.finalScore
    guard finalScore > 0 else { return }
    
    let duration = 0.7
    let step = duration / Double(finalScore)
    
    for i in 1...finalScore {
      try? await Task.sleep(for: .seconds(step))
      
      displayedScore = i
    }
  }
  
}

#Preview {
  let result = EarTrainingResult(
    score: 8,
    totalQuestions: 10,
    totalLives: 3,
    totalReplays: 3,
    livesLeft: 1,
    replaysUsed: 3
  )
  
  EarTrainingResultView(
    viewModel: EarTrainingResultViewModel(
      result: result
    )
  )
}
