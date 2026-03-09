//
//  Palette.swift
//  SharedUI
//
//  Created by Ertan Yağmur on 9.03.2026.
//

import SwiftUI

public struct Palette: Sendable {
  
  public let brand: Color
  public let brandSecondary: Color
  
  public let accent: Color
  public let accentSecondary: Color
  
  public let neutral: Color
  public let neutralSecondary: Color
  
  public init(
    brand: Color,
    brandSecondary: Color,
    accent: Color,
    accentSecondary: Color,
    neutral: Color,
    neutralSecondary: Color
  ) {
    self.brand = brand
    self.brandSecondary = brandSecondary
    self.accent = accent
    self.accentSecondary = accentSecondary
    self.neutral = neutral
    self.neutralSecondary = neutralSecondary
  }
  
}
