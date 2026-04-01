//
//  Module.swift
//  OnboardingPresentation
//
//  Created by Ertan Yağmur on 28.03.2026.
//

import UIKit

public struct ModuleDependencies {
  public init() { }
}

@MainActor
public struct Module {
  
  private let diContainer: DIContainer
  
  public init(dependencies: ModuleDependencies) {
    diContainer = DIContainer(dependencies: dependencies)
  }
  
  public func startOnboardingFlow(
    in navigationController: UINavigationController,
    onFinish: @escaping () -> Void
  ) {
    let flow = diContainer.makeOnboardingFlowCoordinator(
      navigationController: navigationController,
      onFinish: onFinish
    )
    
    flow.start()
  }
  
}
