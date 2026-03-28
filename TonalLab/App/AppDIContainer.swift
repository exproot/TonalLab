//
//  AppDIContainer.swift
//  TonalLab
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import Foundation
import HomePresentation
import TonalLabAudio
import EarTrainingDomain
import EarTrainingPresentation
import OnboardingPresentation

final class AppDIContainer {
  
  weak var earTrainingFlowProvider: EarTrainingFlowProvider?
  
  lazy var onboardingStateRepository: OnboardingStateRepository = UserDefaultsOnboardingStateRepository()
  
  func makeOnboardingModule() -> OnboardingPresentation.Module {
    OnboardingPresentation.Module(dependencies: .init())
  }
  
  func makeHomeModule() -> HomePresentation.Module {
    precondition(earTrainingFlowProvider != nil, "EarTrainingFlowProvider not set")
    
    let dependencies = HomePresentation.ModuleDependencies(
      earTrainingFlowProvider: earTrainingFlowProvider!
    )
    
    return HomePresentation.Module(dependencies: dependencies)
  }
  
  func makeEarTrainingModule() -> EarTrainingPresentation.Module {
    let audioPlayer = PianoSamplePlayer()
    let dependencies = EarTrainingPresentation.ModuleDependencies(
      audioPlayer: audioPlayer
    )
    
    return EarTrainingPresentation.Module(dependencies: dependencies)
  }
  
}
