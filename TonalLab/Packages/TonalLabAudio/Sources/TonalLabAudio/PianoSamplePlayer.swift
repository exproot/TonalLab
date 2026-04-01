//
//  PianoSamplePlayer.swift
//  TonalLabAudio
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import AVFoundation
import EarTrainingDomain

public actor PianoSamplePlayer: AudioPlaying {
  
  private let engine = AVAudioEngine()
  private let player = AVAudioPlayerNode()
  
  public init() {
    engine.attach(player)
    engine.connect(player, to: engine.mainMixerNode, format: nil)
    
    try? engine.start()
  }
  
  public func play(resourceName: String) async throws {
    guard let url = Bundle.module.url(forResource: resourceName, withExtension: "wav") else {
      throw AudioError.fileNotFound
    }
    
    let file = try AVAudioFile(forReading: url)
    
    player.stop()
    
    await player.scheduleFile(file, at: nil)
    
    player.play()
  }
  
}
