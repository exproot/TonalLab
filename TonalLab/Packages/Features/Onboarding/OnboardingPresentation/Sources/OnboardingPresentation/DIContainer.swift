//
//  DIContainer.swift
//  OnboardingPresentation
//
//  Created by Ertan Yağmur on 28.03.2026.
//

import UIKit

@MainActor
final class DIContainer {
  
  let dependencies: ModuleDependencies
  
  init(dependencies: ModuleDependencies) {
    self.dependencies = dependencies
  }
  
  // MARK: ViewModels
  func makeOnboardingViewModel(actions: OnboardingViewModelActions) -> OnboardingViewModel {
    OnboardingViewModel(actions: actions)
  }
  
  // MARK: Flow Coordinator
  func makeOnboardingFlowCoordinator(
    navigationController: UINavigationController,
    onFinish: @escaping () -> Void
  ) -> OnboardingFlowCoordinator {
    OnboardingFlowCoordinator(
      navigationController: navigationController,
      dependencies: self,
      onFinish: onFinish
    )
  }
  
}

// MARK: OnboardingFlowCoordinatorDependencies
extension DIContainer: OnboardingFlowCoordinatorDependencies {
  
  func makeOnboardingHostingController(
    actions: OnboardingViewModelActions
  ) -> OnboardingHostingController {
    let viewModel = makeOnboardingViewModel(actions: actions)
    
    return OnboardingHostingController(
      rootView: OnboardingView(viewModel: viewModel)
    )
  }
  
}
