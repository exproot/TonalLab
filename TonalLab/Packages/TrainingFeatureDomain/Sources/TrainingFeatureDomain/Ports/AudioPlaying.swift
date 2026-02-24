//
//  AudioPlaying.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 24.02.2026.
//

import Foundation

public protocol AudioPlaying: Sendable {
  func play(resourceName: String) async throws
}
