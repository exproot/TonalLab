//
//  OnboardingFlowCoordinator.swift
//  OnboardingPresentation
//
//  Created by Ertan Yağmur on 28.03.2026.
//

import UIKit

@MainActor
protocol OnboardingFlowCoordinatorDependencies {
  func makeOnboardingHostingController(
    actions: OnboardingViewModelActions
  ) -> OnboardingHostingController
}

@MainActor
final class OnboardingFlowCoordinator {
  
  private weak var navigationController: UINavigationController?
  private let dependencies: OnboardingFlowCoordinatorDependencies
  private let onFinish: () -> Void
  
  init(
    navigationController: UINavigationController,
    dependencies: OnboardingFlowCoordinatorDependencies,
    onFinish: @escaping () -> Void
  ) {
    self.navigationController = navigationController
    self.dependencies = dependencies
    self.onFinish = onFinish
  }
  
  func start() {
    // Keeping a strong reference with the onboardingDidComplete on purpose to keep this flow alive
    let actions = OnboardingViewModelActions(onboardingDidComplete: finish)
    
    let viewController = dependencies.makeOnboardingHostingController(actions: actions)
    navigationController?.setViewControllers([viewController], animated: false)
  }
  
  private func finish() {
    onFinish()
  }
  
}
