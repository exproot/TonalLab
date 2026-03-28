//
//  OnboardingPageView.swift
//  OnboardingPresentation
//
//  Created by Ertan Yağmur on 28.03.2026.
//

import DotLottie
import SharedUI
import SwiftUI

struct OnboardingPageView: View {
  
  @Environment(\.theme) private var theme
  
  let page: OnboardingPage
  let lottieAnimation: DotLottieAnimation
  
  init(page: OnboardingPage) {
    self.page = page
    
    lottieAnimation = DotLottieAnimation(
      fileName: page.mediaAssetName,
      bundle: .module,
      config: .init()
    )
  }
  
  var body: some View {
    VStack(spacing: Spacing.medium) {
      DotLottiePlayerView(animation: lottieAnimation)
        .looping()
        .allowsHitTesting(false)
        .frame(height: 220)
      
      Text(page.title)
        .font(Typography.title)
        .multilineTextAlignment(.center)
      
      Text(page.subtitle)
        .font(Typography.body)
        .foregroundStyle(theme.colors.secondary)
        .multilineTextAlignment(.center)
        .padding(.horizontal, Spacing.large)
    }
  }
  
}

#Preview {
  OnboardingPageView(page: OnboardingContent.pages.last!)
}
