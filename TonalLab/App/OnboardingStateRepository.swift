//
//  OnboardingStateRepository.swift
//  TonalLab
//
//  Created by Ertan Yağmur on 28.03.2026.
//

import Foundation

protocol OnboardingStateRepository {
  var hasSeenOnboarding: Bool { get }
  func setHasSeenOnboarding()
}

final class UserDefaultsOnboardingStateRepository: OnboardingStateRepository {
  
  private let defaults: UserDefaults
  private let key = "hasSeenOnboarding"
  
  init(defaults: UserDefaults = .standard) {
    self.defaults = defaults
  }
  
  var hasSeenOnboarding: Bool {
    defaults.bool(forKey: key)
  }
  
  func setHasSeenOnboarding() {
    defaults.set(true, forKey: key)
  }
  
}
