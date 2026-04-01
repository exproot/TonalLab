//
//  OnboardingViewModel.swift
//  OnboardingPresentation
//
//  Created by Ertan Yağmur on 28.03.2026.
//

import Foundation

struct OnboardingPage: Identifiable {
  let id = UUID()
  let title: String
  let subtitle: String
  let mediaAssetName: String
}

enum OnboardingContent {
  static let pages: [OnboardingPage] = [
    OnboardingPage(
      title: "Welcome to TonalLab",
      subtitle: "Train your ear with short note-based exercises and build pitch recognition step by step.",
      mediaAssetName: "onboardingWelcome"
    ),
    
    OnboardingPage(
      title: "Practice at your own pace",
      subtitle: "Replay sounds, take your time, and focus on learning each note without pressure.",
      mediaAssetName: "onboardingPractice"
    ),
    
    OnboardingPage(
      title: "Challenge yourself in Game Mode",
      subtitle: "Test your accuracy with limited lives and replays, then track how well you performed.",
      mediaAssetName: "onboardingGame"
    )
  ]
}

struct OnboardingViewModelActions {
  let onboardingDidComplete: () -> Void
}

@MainActor
final class OnboardingViewModel: ObservableObject {
  
  // MARK: Dependencies
  private let actions: OnboardingViewModelActions
  
  // MARK: Output
  @Published var currentPageIndex = 0
  
  let pages: [OnboardingPage]
  
  // MARK: Init
  init(
    pages: [OnboardingPage] = OnboardingContent.pages,
    actions: OnboardingViewModelActions
  ) {
    self.pages = pages
    self.actions = actions
  }
  
  // MARK: Computed
  var isLastPage: Bool {
    currentPageIndex == pages.count - 1
  }
  
  var primaryButtonTitle: String {
    isLastPage ? "Get Started" : "Next"
  }
  
  var showsSkipButton: Bool {
    !isLastPage
  }
  
  var progressText: String {
    "\(currentPageIndex + 1) / \(pages.count)"
  }
  
  // MARK: Input
  func advancePage() {
    guard !isLastPage else {
      actions.onboardingDidComplete()
      return
    }
    
    currentPageIndex += 1
  }
  
  func skip() {
    actions.onboardingDidComplete()
  }
  
}
