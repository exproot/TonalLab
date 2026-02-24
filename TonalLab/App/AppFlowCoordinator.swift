//
//  AppFlowCoordinator.swift
//  TonalLab
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import UIKit
import TrainingFeaturePresentation

final class AppFlowCoordinator {
  
  private weak var navigationController: UINavigationController?
  private let appDIContainer: AppDIContainer
  
  init(
    navigationController: UINavigationController,
    appDIContainer: AppDIContainer
  ) {
    self.navigationController = navigationController
    self.appDIContainer = appDIContainer
  }
  
  func start() {
    guard let navigationController else { return }
    let trainingModule = appDIContainer.makeTrainingModule()
    
    trainingModule.startTrainingFlow(in: navigationController)
  }
  
}
