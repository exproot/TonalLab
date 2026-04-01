//
//  PhaseCardView.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import EarTrainingDomain
import SharedUI
import SwiftUI

struct PhaseCardView: View {
  
  @Environment(\.theme) private var theme
  
  let phase: Phase
  let phaseText: String
  let phaseImageString: String
  let canReplay: Bool
  let onReplay: () -> Void
  
  var body: some View {
    VStack(spacing: Spacing.large) {
      Image(systemName: phaseImageString)
        .font(Typography.title)
        .foregroundStyle(phaseColor)
        .frame(width: 48, height: 48)
        .rotationEffect(phase == .resolvingAnswer ? .degrees(180) : .zero)
        .animation(AppAnimation.spring, value: phase)
      
      Text(phaseText)
        .font(.title3.bold())
        .multilineTextAlignment(.center)
        .frame(minHeight: 24)
      
      Button {
        onReplay()
      } label: {
        HStack {
          Image(systemName: "speaker.wave.2.fill")
          
          Text("Replay")
            .fontWeight(.semibold)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
        .background(
          Capsule()
            .fill(canReplay ? phaseColor : phaseColor.opacity(0.2))
            .shadow(color: phaseColor.opacity(0.4), radius: 6, y: 3)
        )
        .foregroundStyle(.white)
      }
      .disabled(!canReplay)
      
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerRadius: Radius.large)
        .fill(backgroundGradient)
        .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
    )
    .animation(AppAnimation.card, value: phase)
    .scaleEffect(phase == .resolvingAnswer ? 1.02 : 1.0)
  }
  
  private var phaseColor: Color {
    switch phase {
    case .idle, .finished: theme.colors.semantic.idle
    case .waitingForAnswer: theme.colors.semantic.success
    case .resolvingAnswer: theme.colors.semantic.warning
    }
  }
  
  private var backgroundGradient: LinearGradient {
    let base = phaseColor
    
    return LinearGradient(
      colors: [base.opacity(0.25), base.opacity(0.08)],
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
  }
  
}

#Preview {
  PhaseCardView(
    phase: .waitingForAnswer,
    phaseText: "Listen and choose the correct note",
    phaseImageString: "ear.badge.waveform",
    canReplay: true,
    onReplay: { })
}
