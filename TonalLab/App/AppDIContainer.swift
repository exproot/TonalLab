//
//  AppDIContainer.swift
//  TonalLab
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import Foundation
import TonalLabAudio
import TrainingFeatureDomain
import TrainingFeaturePresentation

final class AppDIContainer {
  
  func makeTrainingModule() -> TrainingFeaturePresentation.Module {
    let engine = TrainingEngine()
    let dependencies = TrainingFeaturePresentation.ModuleDependencies(
      trainingEngine: engine,
      audioPlayer: PianoSamplePlayer()
    )
    
    return TrainingFeaturePresentation.Module(dependencies: dependencies)
  }
  
}
