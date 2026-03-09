//
//  ThemeColors.swift
//  SharedUI
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import SwiftUI

public struct ThemeColors: Sendable {
  
  public let palette: Palette
  public let semantic: SemanticColors
  
  public let primary: Color
  public let secondary: Color
  
  public let backgroundGradient: [Color]
  
  public init(
    palette: Palette,
    semantic: SemanticColors,
    primary: Color,
    secondary: Color,
    backgroundGradient: [Color]
  ) {
    self.palette = palette
    self.semantic = semantic
    self.primary = primary
    self.secondary = secondary
    self.backgroundGradient = backgroundGradient
  }
  
}
