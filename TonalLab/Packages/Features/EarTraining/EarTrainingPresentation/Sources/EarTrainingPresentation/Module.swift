//
//  Module.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import UIKit
import EarTrainingDomain

public struct ModuleDependencies {
  
  public let audioPlayer: AudioPlaying
  
  public init(audioPlayer: AudioPlaying) {
    self.audioPlayer = audioPlayer
  }
  
}

@MainActor
public struct Module {
  
  private let diContainer: DIContainer
  
  public init(dependencies: ModuleDependencies) {
    self.diContainer = DIContainer(dependencies: dependencies)
  }
 
  public func startEarTrainingFlow(
    in navigationController: UINavigationController,
    with mode: EarTrainingMode
  ) {
    let flow = diContainer.makeEarTrainingFlowCoordinator(navigationController: navigationController)
    
    flow.start(mode: mode)
  }
  
}
