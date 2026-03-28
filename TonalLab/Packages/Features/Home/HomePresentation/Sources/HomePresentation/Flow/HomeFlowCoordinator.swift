//
//  HomeFlowCoordinator.swift
//  HomePresentation
//
//  Created by Ertan Yağmur on 9.03.2026.
//

import UIKit

@MainActor
protocol HomeFlowCoordinatorDependencies {
  func makeHomeHostingController(actions: HomeViewModelActions) -> HomeHostingController
}

@MainActor
final class HomeFlowCoordinator {
  
  private weak var navigationController: UINavigationController?
  private let earTrainingFlowProvider: EarTrainingFlowProvider
  private let dependencies: HomeFlowCoordinatorDependencies
  
  init(
    navigationController: UINavigationController,
    earTrainingFlowProvider: EarTrainingFlowProvider,
    dependencies: HomeFlowCoordinatorDependencies
  ) {
    self.navigationController = navigationController
    self.earTrainingFlowProvider = earTrainingFlowProvider
    self.dependencies = dependencies
  }
  
  func start() {
    // Keeping a strong reference with the closure on purpose to keep this flow alive
    let actions = HomeViewModelActions(startTraining: showEarTraining)
    let viewController = dependencies.makeHomeHostingController(actions: actions)
    
    navigationController?.setViewControllers([viewController], animated: true)
  }
  
  private func showEarTraining(selection: HomeTrainingSelection) {
    guard let navigationController else { return }
    
    earTrainingFlowProvider.startEarTrainingFlow(
      in: navigationController,
      with: selection
    )
  }
  
}
