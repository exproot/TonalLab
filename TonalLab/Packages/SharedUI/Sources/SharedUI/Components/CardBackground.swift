//
//  CardBackground.swift
//  SharedUI
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import SwiftUI

public struct CardBackground: View {
  
  let shadowColor: Color
  
  public init(shadowColor: Color = .black.opacity(0.08)) {
    self.shadowColor = shadowColor
  }
  
  public var body: some View {
    RoundedRectangle(cornerRadius: Radius.large)
      .fill(.thinMaterial)
      .shadow(color: shadowColor, radius: 8, y: 4)
  }
  
}
