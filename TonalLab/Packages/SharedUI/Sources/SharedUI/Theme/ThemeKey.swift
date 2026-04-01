//
//  ThemeKey.swift
//  SharedUI
//
//  Created by Ertan Yağmur on 6.03.2026.
//


import SwiftUI

private struct ThemeKey: EnvironmentKey {
  
  static let defaultValue: AppTheme = .tonalLab
  
}

public extension EnvironmentValues {
  
  var theme: AppTheme {
    get { self[ThemeKey.self] }
    set { self[ThemeKey.self] = newValue }
  }
  
}

public extension View {
  
  func appTheme(_ theme: AppTheme) -> some View {
    environment(\.theme, theme)
  }
  
}
