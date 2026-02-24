//
//  TrainingModuleFlowCoordinator.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import UIKit

@MainActor
protocol TrainingModuleFlowCoordinatorDependencies {
  func makeTrainingHostingController() -> TrainingHostingController
}

@MainActor
final class TrainingModuleFlowCoordinator {
  
  private weak var navigationController: UINavigationController?
  private let dependencies: TrainingModuleFlowCoordinatorDependencies
  
  init(
    navigationController: UINavigationController,
    dependencies: TrainingModuleFlowCoordinatorDependencies
  ) {
    self.navigationController = navigationController
    self.dependencies = dependencies
  }
  
  func start() {
    let viewController = dependencies.makeTrainingHostingController()
    
    navigationController?.pushViewController(viewController, animated: false)
  }
  
}
