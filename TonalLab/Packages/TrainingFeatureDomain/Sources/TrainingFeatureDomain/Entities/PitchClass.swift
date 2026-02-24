//
//  PitchClass.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 13.02.2026.
//

import Foundation

public enum PitchClass: Int, CaseIterable, Sendable {
  case c = 0
  case cSharp
  case d
  case dSharp
  case e
  case f
  case fSharp
  case g
  case gSharp
  case a
  case aSharp
  case b
}

public extension PitchClass {
  var displayName: String {
    switch self {
    case .c: return "C"
    case .cSharp: return "C#"
    case .d: return "D"
    case .dSharp: return "D#"
    case .e: return "E"
    case .f: return "F"
    case .fSharp: return "F#"
    case .g: return "G"
    case .gSharp: return "G#"
    case .a: return "A"
    case .aSharp: return "A#"
    case .b: return "B"
    }
  }
}

public extension PitchClass {
  var audioResourceName: String {
    switch self {
    case .c: return "piano_c"
    case .d: return "piano_d"
    case .e: return "piano_e"
    case .f: return "piano_f"
    case .g: return "piano_g"
    case .a: return "piano_a"
    case .b: return "piano_b"
    default: return ""
    }
  }
}
