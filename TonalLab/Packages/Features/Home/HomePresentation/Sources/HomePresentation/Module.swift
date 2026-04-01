//
//  Module.swift
//  HomePresentation
//
//  Created by Ertan Yağmur on 9.03.2026.
//

import UIKit

public struct ModuleDependencies {
  
  public let earTrainingFlowProvider: EarTrainingFlowProvider
  
  public init(earTrainingFlowProvider: EarTrainingFlowProvider) {
    self.earTrainingFlowProvider = earTrainingFlowProvider
  }
  
}

@MainActor
public struct Module {
  
  private let diContainer: DIContainer
  
  public init(dependencies: ModuleDependencies) {
    self.diContainer = DIContainer(dependencies: dependencies)
  }
  
  public func startHomeFlow(in navigationController: UINavigationController) {
    let flow = diContainer.makeHomeCoordinator(navigationController: navigationController)
    
    flow.start()
  }
  
}

public protocol EarTrainingFlowProvider: AnyObject {
  func startEarTrainingFlow(
    in navigationController: UINavigationController,
    with selection: HomeTrainingSelection
  )
}
