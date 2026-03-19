//
//  EarTrainingFlowCoordinator.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import UIKit
import EarTrainingDomain

@MainActor
protocol EarTrainingFlowCoordinatorDependencies {
  func makeEarTrainingHostingController(
    actions: EarTrainingViewModelActions,
    mode: EarTrainingMode
  ) -> EarTrainingHostingController
  
  func makeEarTrainingResultHostingController(
    result: EarTrainingResult,
    actions: EarTrainingResultViewModelActions
  ) -> EarTrainingResultHostingController
}

@MainActor
final class EarTrainingFlowCoordinator {
  
  private weak var navigationController: UINavigationController?
  private let dependencies: EarTrainingFlowCoordinatorDependencies
  
  init(
    navigationController: UINavigationController,
    dependencies: EarTrainingFlowCoordinatorDependencies
  ) {
    self.navigationController = navigationController
    self.dependencies = dependencies
  }
  
  func start(mode: EarTrainingMode) {
    // Keeping a strong reference with the closure on purpose to keep this flow alive
    let actions = EarTrainingViewModelActions(showResult: showResult)
    let viewController = dependencies.makeEarTrainingHostingController(actions: actions, mode: mode)
    
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  private func showResult(result: EarTrainingResult) {
    let actions = EarTrainingResultViewModelActions { [weak self] in
      self?.navigationController?.popToRootViewController(animated: true)
    }
    
    let viewController = dependencies.makeEarTrainingResultHostingController(
      result: result,
      actions: actions
    )
    
    navigationController?.pushViewController(viewController, animated: true)
  }
  
}
