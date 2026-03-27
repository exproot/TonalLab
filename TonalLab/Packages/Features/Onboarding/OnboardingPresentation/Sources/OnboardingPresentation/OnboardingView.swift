//
//  OnboardingView.swift
//  OnboardingPresentation
//
//  Created by Ertan Yağmur on 20.03.2026.
//

import SharedUI
import SwiftUI

struct OnboardingView: View {
  
  @Environment(\.theme) private var theme
  
  let viewModel: OnboardingViewModel
  
  var body: some View {
    VStack(spacing: 0) {
      ScrollView(.vertical) {
        VStack(spacing: Spacing.medium) {
          icon
            .frame(maxWidth: .infinity)
          
          Text("Welcome to TonalLab")
            .font(Typography.title)
          
          CardsView()
        }
      }
      .scrollIndicators(.hidden)
      .scrollBounceBehavior(.basedOnSize)
      
      VStack {
        footer
        
        Button(action: viewModel.onboardingDidComplete) {
          Text("Continue")
        }
        .buttonStyle(PrimaryButtonStyle())
      }
    }
    .frame(maxWidth: 320)
    .interactiveDismissDisabled()
  }
  
  var icon: some View {
    // TODO: Replace with app icon.
    Image(systemName: "waveform.circle")
      .font(.system(size: IconSize.extraExtraLarge))
      .frame(width: 100, height: 100)
      .foregroundStyle(.white)
      .background(theme.colors.palette.brand.gradient, in: .rect(cornerRadius: 24))
      .frame(height: 100)
  }
  
  var footer: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      Image(systemName: "person.3.fill")
        .foregroundStyle(.red)
      
      Text("Footer disclosure text, footer disclosure text, footer disclosure text.")
        .font(Typography.caption)
    }
  }
  
  @ViewBuilder
  func CardsView() -> some View {
    Group {
      ForEach(viewModel.cards.indices, id:\.self) { index in
        let card = viewModel.cards[index]
        
        HStack(alignment: .top, spacing: Spacing.medium) {
          Image(systemName: card.systemImage)
            .font(.title2)
            .foregroundStyle(theme.colors.palette.brandSecondary)
            .symbolVariant(.fill)
            .frame(width: 44)
          
          VStack(alignment: .leading, spacing: Spacing.small) {
            Text(card.title)
              .font(.title3)
              .lineLimit(1)
            
            Text(card.subtitle)
              .lineLimit(2)
          }
        }
      }
    }
  }
  
}

#Preview {
  OnboardingView(
    viewModel: OnboardingViewModel(
      actions: OnboardingViewModelActions(didTapContinue: { })
    )
  )
}
