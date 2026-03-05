//
//  EarTrainingResultView.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 5.03.2026.
//

import EarTrainingDomain
import DotLottie
import SwiftUI

struct EarTrainingResultView: View {
  
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
    VStack(spacing: 24) {
      VStack(spacing: 8) {
        Text(viewModel.uiModel.title)
          .font(.title.bold())
        
        Text(viewModel.uiModel.subtitle)
          .font(.subheadline)
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
    .padding()
    .background(
      LinearGradient(
        colors: [.blue.opacity(0.12), .purple.opacity(0.06)],
        startPoint: .top,
        endPoint: .bottom
      )
    )
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
    VStack(spacing: 24) {
      ZStack {
        Circle()
          .stroke(.gray.opacity(0.18), lineWidth: 14)
        
        Circle()
          .trim(from: 0, to: animatedProgress)
          .stroke(
            ringColor,
            style: StrokeStyle(lineWidth: 14, lineCap: .butt)
          )
          .shadow(
            color: ringColor.opacity(viewModel.uiModel.ringGlowOpacity),
            radius: 10,
            y: 6
          )
          .rotationEffect(.degrees(-90))
        
        VStack(spacing: 6) {
          Text("\(displayedScore) / \(viewModel.uiModel.totalQuestions)")
            .font(.title2.bold())
            .monospacedDigit()
          
          Text("Grade: \(viewModel.uiModel.gradeText)")
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.secondary)
        }
      }
      .frame(width: 180, height: 180)
      
      HStack(spacing: 8) {
        Image(systemName: "sparkles")
        
        Text("Accuracy \(Int(viewModel.uiModel.progress * 100))%")
          .monospacedDigit()
      }
      .font(.subheadline.weight(.semibold))
      .padding(.horizontal, 12)
      .padding(.vertical, 8)
      .background(.thinMaterial, in: .capsule)
    }
    .padding(.top, 10)
  }
  
  private var actionButtons: some View {
    VStack(spacing: 12) {
      Button {
        // TODO: Play again
      } label: {
        Text(viewModel.uiModel.primaryButtonTitle)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 14)
          .background(Capsule().fill(Color.accentColor))
          .foregroundStyle(.white)
      }
      
      Button {
        // TODO: Practice
      } label: {
        Text(viewModel.uiModel.secondaryButtonTitle)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 14)
          .background(Capsule().fill(Color.gray.opacity(0.18)))
      }
    }
    .font(.headline)
    .padding(.top, 8)
  }
  
  private var statsSection: some View {
    HStack(spacing: 12) {
      ForEach(viewModel.uiModel.stats) { stat in
        statCard(stat)
      }
    }
  }
  
  private var ringColor: Color {
    switch viewModel.uiModel.ringColor {
    case .green: .green
    case .yellow: .yellow
    case .orange: .orange
    case .red: .red
    }
  }
  
  private func statCard(_ stat: EarTrainingResultViewModel.ResultStat) -> some View {
    VStack(spacing: 6) {
      Image(systemName: iconName(for: stat.type))
        .font(.headline)
        .foregroundStyle(iconColor(for: stat.type))
      
      Text(stat.title)
        .font(.caption)
        .foregroundStyle(.secondary)
      
      Text(stat.value)
        .font(.headline)
        .monospacedDigit()
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 12)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(.thinMaterial)
    )
  }
  
  private func iconName(for type: EarTrainingResultViewModel.ResultStat.StatType) -> String {
    switch type {
    case .lives: return "heart.fill"
    case .replays: return "speaker.wave.2.fill"
    }
  }
  
  private func iconColor(for type: EarTrainingResultViewModel.ResultStat.StatType) -> Color {
    switch type {
    case .lives: return .red
    case .replays:return .primary
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
