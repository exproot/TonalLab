//
//  AppTheme.swift
//  SharedUI
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import SwiftUI

public struct AppTheme: Sendable {
  
  public let colors: ThemeColors
  
  public init(colors: ThemeColors) {
    self.colors = colors
  }
  
}

public extension AppTheme {
  
  static let tonalLab = AppTheme(
    colors: ThemeColors(
      palette: Palette(
        brand: .green,
        brandSecondary: .red,
        accent: .orange,
        accentSecondary: .yellow,
        neutral: .gray,
        neutralSecondary: .secondary
      ),
      semantic: SemanticColors(
        success: .green,
        warning: .orange,
        error: .red,
        info: .yellow,
        idle: .gray
      ),
      primary: .accentColor,
      secondary: .secondary,
      backgroundGradient: [
        .blue.opacity(0.12),
        .purple.opacity(0.06)
      ]
    )
  )
  
}
