//
//  AppFlowCoordinator.swift
//  TonalLab
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import UIKit
import HomePresentation
import EarTrainingDomain
import EarTrainingPresentation
import OnboardingPresentation

final class AppFlowCoordinator {
  
  private weak var navigationController: UINavigationController?
  private let appDIContainer: AppDIContainer
  private let onboardingStateRepository: OnboardingStateRepository
  
  init(
    navigationController: UINavigationController,
    appDIContainer: AppDIContainer
  ) {
    self.navigationController = navigationController
    self.appDIContainer = appDIContainer
    self.onboardingStateRepository = appDIContainer.onboardingStateRepository
    
    appDIContainer.earTrainingFlowProvider = self
  }
  
  func start() {
    routeToInitialFlow()
  }
  
  private func routeToInitialFlow() {
    if onboardingStateRepository.hasSeenOnboarding {
      showHome()
    } else {
      showOnboarding()
    }
  }
  
  private func showOnboarding() {
    guard let navigationController else { return }
    
    let onboardingModule = appDIContainer.makeOnboardingModule()
    onboardingModule.startOnboardingFlow(in: navigationController) { [weak self] in
      self?.completeOnboarding()
    }
  }
  
  private func completeOnboarding() {
    onboardingStateRepository.setHasSeenOnboarding()
    showHome()
  }
  
  private func showHome() {
    guard let navigationController else { return }
    
    let homeModule = appDIContainer.makeHomeModule()
    homeModule.startHomeFlow(in: navigationController)
  }
  
}

// MARK: EarTrainingFlowProvider
extension AppFlowCoordinator: EarTrainingFlowProvider {
  
  func startEarTrainingFlow(
    in navigationController: UINavigationController,
    with selection: HomeTrainingSelection
  ) {
    let earTrainingModule =  appDIContainer.makeEarTrainingModule()
    let mode: EarTrainingMode
    
    switch selection {
    case .practice:
      mode = .practice
    case .game:
      mode = EarTrainingMode.game(totalQuestions: 10, totalLives: 3, totalAudioReplays: 3)
    }
    
    earTrainingModule.startEarTrainingFlow(in: navigationController, with: mode)
  }
  
}
