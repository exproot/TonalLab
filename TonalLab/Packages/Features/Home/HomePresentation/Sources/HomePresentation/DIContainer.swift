//
//  DIContainer.swift
//  HomePresentation
//
//  Created by Ertan Yağmur on 9.03.2026.
//

import UIKit

@MainActor
final class DIContainer {
  
  private let dependencies: ModuleDependencies
  
  init(dependencies: ModuleDependencies) {
    self.dependencies = dependencies
  }
  
  // MARK: View Model
  func makeHomeViewModel(actions: HomeViewModelActions) -> HomeViewModel {
    HomeViewModel(actions: actions)
  }
  
  // MARK: Flow Coordinator
  func makeHomeCoordinator(navigationController: UINavigationController) -> HomeFlowCoordinator {
    HomeFlowCoordinator(
      navigationController: navigationController,
      earTrainingFlowProvider: dependencies.earTrainingFlowProvider,
      dependencies: self
    )
  }
  
}

// MARK: HomeFlowCoordinatorDependencies
extension DIContainer: HomeFlowCoordinatorDependencies {
  
  func makeHomeHostingController(actions: HomeViewModelActions) -> HomeHostingController {
    HomeHostingController(
      rootView: HomeView(viewModel: HomeViewModel(actions: actions))
    )
  }

}
