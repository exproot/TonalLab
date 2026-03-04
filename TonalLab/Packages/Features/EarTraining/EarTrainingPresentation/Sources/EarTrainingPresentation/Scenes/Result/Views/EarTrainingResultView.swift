//
//  EarTrainingResultView.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 5.03.2026.
//

import SwiftUI

struct EarTrainingResultView: View {
  
  @ObservedObject var viewModel: EarTrainingResultViewModel
  
  @State private var animatedProgress: Double = 0
  
  var body: some View {
    VStack(spacing: 24) {
      VStack(spacing: 8) {
        Text(viewModel.uiModel.title)
          .font(.title.bold())
        
        Text(viewModel.uiModel.subtitle)
          .font(.subheadline)
          .foregroundStyle(.secondary)
      }
      
      scoreRing
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
    .onAppear {
      animatedProgress = 0
      withAnimation(.easeInOut(duration: 0.5)) {
        animatedProgress = viewModel.uiModel.progress
      }
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
            AngularGradient(
              colors: [.green, .mint, .cyan, .blue],
              center: .center
            ),
            style: StrokeStyle(lineWidth: 14, lineCap: .butt)
          )
          .rotationEffect(.degrees(-90))
        
        VStack(spacing: 6) {
          Text(viewModel.uiModel.scoreText)
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
  
}

#Preview {
  EarTrainingResultView(
    viewModel: EarTrainingResultViewModel(
      score: 10,
      totalQuestions: 10
    )
  )
}
