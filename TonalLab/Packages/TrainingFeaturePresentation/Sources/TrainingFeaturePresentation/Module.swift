//
//  Module.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import UIKit
import TrainingFeatureDomain

public struct ModuleDependencies {
  
  public let trainingEngine: TrainingEngine
  public let audioPlayer: AudioPlaying
  
  public init(
    trainingEngine: TrainingEngine,
    audioPlayer: AudioPlaying
  ) {
    self.trainingEngine = trainingEngine
    self.audioPlayer = audioPlayer
  }
}

@MainActor
public struct Module {
  
  private let diContainer: DIContainer
  
  public init(dependencies: ModuleDependencies) {
    self.diContainer = DIContainer(dependencies: dependencies)
  }
 
  public func startTrainingFlow(in navigationController: UINavigationController) {
    let flow = diContainer.makeTrainingModuleFlowCoordinator(navigationController: navigationController)
    
    flow.start()
  }
  
}
