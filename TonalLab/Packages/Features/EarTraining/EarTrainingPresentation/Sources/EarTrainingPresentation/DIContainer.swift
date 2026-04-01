//
//  DIContainer.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import UIKit
import EarTrainingDomain

@MainActor
final class DIContainer {
  
  private let dependencies: ModuleDependencies
  
  init(dependencies: ModuleDependencies) {
    self.dependencies = dependencies
  }
  
  // MARK: ViewModels
  func makeEarTrainingViewModel(
    actions: EarTrainingViewModelActions,
    mode: EarTrainingMode
  ) -> EarTrainingViewModel {
    let context = EarTrainingContext(mode: mode)
    
    let selector = RandomQuestionSelector(scale: .cMajor)
    let strategy = RandomQuestionStrategy(selector: selector)
    
    let engine = EarTrainingEngine(context: context)
    let session = EarTrainingSession(
      mode: mode,
      engine: engine,
      strategy: strategy,
      audioPlayer: dependencies.audioPlayer
    )
    
    return EarTrainingViewModel(
      session: session,
      actions: actions
    )
  }
  
  func makeEarTrainingResultViewModel(
    result: EarTrainingResult,
    actions: EarTrainingResultViewModelActions
  ) -> EarTrainingResultViewModel {
    .init(result: result, actions: actions)
  }
  
  // MARK: Flow Coordinators
  func makeEarTrainingFlowCoordinator(
    navigationController: UINavigationController
  ) -> EarTrainingFlowCoordinator {
    EarTrainingFlowCoordinator(
      navigationController: navigationController,
      dependencies: self
    )
  }
  
}

// MARK: EarTrainingFlowCoordinatorDependencies
extension DIContainer: EarTrainingFlowCoordinatorDependencies {

  func makeEarTrainingHostingController(
    actions: EarTrainingViewModelActions,
    mode: EarTrainingMode
  ) -> EarTrainingHostingController {
    EarTrainingHostingController(
      rootView: EarTrainingView(viewModel: makeEarTrainingViewModel(actions: actions, mode: mode))
    )
  }
  
  func makeEarTrainingResultHostingController(
    result: EarTrainingResult,
    actions: EarTrainingResultViewModelActions
  ) -> EarTrainingResultHostingController {
    EarTrainingResultHostingController(
      rootView: EarTrainingResultView(
        viewModel: makeEarTrainingResultViewModel(result: result, actions: actions)
      )
    )
  }

}
