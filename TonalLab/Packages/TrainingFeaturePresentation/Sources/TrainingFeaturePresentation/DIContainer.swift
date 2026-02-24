//
//  DIContainer.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import UIKit
import TrainingFeatureDomain

@MainActor
final class DIContainer {
  
  private let dependencies: ModuleDependencies
  
  init(dependencies: ModuleDependencies) {
    self.dependencies = dependencies
  }
  
  // MARK: ViewModels
  func makeTrainingViewModel() -> TrainingViewModel {
    let selector = RandomQuestionSelector(scale: .cMajor)
    let strategy = RandomQuestionStrategy(selector: selector)
    let session = TrainingSession(
      engine: TrainingEngine(),
      strategy: strategy,
      audioPlayer: dependencies.audioPlayer
    )
    
    return TrainingViewModel(
      session: session
    )
  }
  
  // MARK: Flow Coordinators
  func makeTrainingModuleFlowCoordinator(navigationController: UINavigationController) -> TrainingModuleFlowCoordinator {
    TrainingModuleFlowCoordinator(
      navigationController: navigationController,
      dependencies: self
    )
  }
  
}

// MARK: TrainingModuleFlowCoordinatorDependencies
extension DIContainer: TrainingModuleFlowCoordinatorDependencies {
  
  func makeTrainingHostingController() -> TrainingHostingController {
    TrainingHostingController(
      rootView: TrainingView(viewModel: makeTrainingViewModel())
    )
  }

}
