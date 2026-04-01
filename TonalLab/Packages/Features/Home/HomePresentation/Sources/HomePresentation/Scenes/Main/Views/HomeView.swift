//
//  HomeView.swift
//  HomePresentation
//
//  Created by Ertan Yağmur on 9.03.2026.
//

import SharedUI
import SwiftUI

struct HomeView: View {
  
  @Environment(\.theme) private var theme
  
  let viewModel: HomeViewModel
  
  var body: some View {
    ScreenContainer {
      VStack(spacing: Spacing.extraLarge) {
        header
        
        modes
        
        Spacer()
      }
    }
  }
  
}

// MARK: Header
private extension HomeView {
  var header: some View {
    VStack(spacing: Spacing.medium) {
      Image(systemName: "waveform.circle.fill")
        .font(.system(size: IconSize.extraLarge))
        .foregroundStyle(theme.colors.primary)
      
      VStack(spacing: Spacing.small) {
        Text("TonalLab")
          .font(Typography.title)
        
        Text("Train your musical ear")
          .font(Typography.subtitle)
          .foregroundStyle(theme.colors.secondary)
      }
    }
    .padding(.top, Spacing.large)
  }
}

// MARK: Mode Cards
private extension HomeView {
  var modes: some View {
    VStack(spacing: Spacing.large) {
      ModeCardView(
        title: "Practice Mode",
        subtitle: "Train freely without losing lives",
        systemImage: "music.note",
        tint: theme.colors.semantic.success,
        action: { viewModel.didTapStartPractice() }
      )
      
      ModeCardView(
        title: "Game Mode",
        subtitle: "Answer correctly before lives run out",
        systemImage: "gamecontroller.fill",
        tint: theme.colors.semantic.warning,
        action: { viewModel.didTapStartGame() }
      )
    }
  }
}

#Preview {
  HomeView(
    viewModel: HomeViewModel(
      actions: .init(
        startTraining: { _ in }
      )
    )
  )
}
