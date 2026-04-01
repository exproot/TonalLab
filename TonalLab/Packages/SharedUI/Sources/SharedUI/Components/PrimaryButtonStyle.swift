//
//  PrimaryButtonStyle.swift
//  SharedUI
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
  
  let backgroundColor: Color
  let foregroundColor: Color
  
  public init(
    backgroundColor: Color = .accentColor,
    foregroundColor: Color = .white
  ) {
    self.backgroundColor = backgroundColor
    self.foregroundColor = foregroundColor
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(maxWidth: .infinity)
      .padding(.vertical, 14)
      .background(Capsule().fill(backgroundColor))
      .foregroundStyle(foregroundColor)
      .scaleEffect(configuration.isPressed ? 0.96 : 1)
  }
  
}
