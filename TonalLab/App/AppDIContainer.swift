//
//  AppDIContainer.swift
//  TonalLab
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import Foundation
import TonalLabAudio
import EarTrainingDomain
import EarTrainingPresentation

final class AppDIContainer {
  
  func makeEarTrainingModule() -> EarTrainingPresentation.Module {
    let audioPlayer = PianoSamplePlayer()
    let dependencies = EarTrainingPresentation.ModuleDependencies(
      audioPlayer: audioPlayer
    )
    
    return EarTrainingPresentation.Module(dependencies: dependencies)
  }
  
}
