//
//  Scale.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import Foundation

public struct Scale: Sendable, Equatable {
  
  public let notes: [PitchClass]
  
  public init(notes: [PitchClass]) {
    self.notes = notes
  }
  
}

public extension Scale {
  static let cMajor = Scale(
    notes: [
      .c, .d, .e, .f, .g, .a, .b
    ]
  )
}
