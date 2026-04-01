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
  
  @ObservedObject var viewModel: OnboardingViewModel
  
  var body: some View {
    ScreenContainer {
      VStack(spacing: 0) {
        topBar
        
        TabView(selection: $viewModel.currentPageIndex) {
          ForEach(Array(viewModel.pages.enumerated()), id: \.element.id) { index, page in
            VStack(spacing: 0){
              OnboardingPageView(page: page)
            }
            .tag(index)
          }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        
        pageIndicator
          .padding(.top, Spacing.medium)
        
        Spacer()
        
        Button(action: viewModel.advancePage) {
          Text(viewModel.primaryButtonTitle)
        }
        .buttonStyle(PrimaryButtonStyle())
        .padding(.top, Spacing.large)
      }
    }
  }
  
  private var topBar: some View {
    HStack {
      Button(action: viewModel.skip) {
        CapsuleChip {
          Text("Skip")
        }
      }
      .opacity(viewModel.showsSkipButton ? 1 : 0)
      .disabled(!viewModel.showsSkipButton)
      
      Spacer()
      
      Text(viewModel.progressText)
        .font(Typography.caption)
        .foregroundStyle(theme.colors.secondary)
    }
    .padding(.horizontal, Spacing.large)
    .padding(.bottom, Spacing.medium)
  }
  
  private var pageIndicator: some View {
    HStack(spacing: Spacing.small) {
      ForEach(0..<viewModel.pages.count, id: \.self) { index in
          Capsule()
          .frame(width: viewModel.currentPageIndex == index ? 20 : 8, height: 8)
          .foregroundStyle(
            viewModel.currentPageIndex == index
            ? theme.colors.primary
            : theme.colors.secondary
          )
          .animation(.easeInOut(duration: 0.2), value: viewModel.currentPageIndex)
      }
    }
  }
  
}

#Preview {
  OnboardingView(
    viewModel: OnboardingViewModel(
      actions: OnboardingViewModelActions(onboardingDidComplete: { })
    )
  )
}
