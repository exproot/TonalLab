// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

struct OnboardingCard: Identifiable {
  
  let id: String
  let systemImage: String
  let title: String
  let subtitle: String
  
  init(
    id: String = UUID().uuidString,
    systemImage: String,
    title: String,
    subtitle: String
  ) {
    self.id = id
    self.systemImage = systemImage
    self.title = title
    self.subtitle = subtitle
  }
  
}

struct OnboardingViewModelActions {
  let didTapContinue: () -> Void
}

struct OnboardingViewModel {
  
  private let actions: OnboardingViewModelActions
  
  private(set) var cards: [OnboardingCard] = [
    OnboardingCard(
      systemImage: "house",
      title: "Title title title title title title title title title#1",
      subtitle: "Subtitle subtitle subtitle subtitle subtitle subtitle subtitle #1"
    ),
    
    OnboardingCard(
      systemImage: "person",
      title: "Title title title title title title title title title #2",
      subtitle: "Subtitle subtitle subtitle subtitle subtitle subtitle subtitle #2"
    ),
    
    OnboardingCard(
      systemImage: "location",
      title: "Title title title title title title title title title #3",
      subtitle: "Subtitle subtitle subtitle subtitle subtitle subtitle subtitle #3"
    ),
  ]
  
  init(actions: OnboardingViewModelActions) {
    self.actions = actions
  }
  
  func onboardingDidComplete() {
    actions.didTapContinue()
  }
  
}
