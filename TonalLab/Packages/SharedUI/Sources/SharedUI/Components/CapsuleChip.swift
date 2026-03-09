//
//  CapsuleChip.swift
//  SharedUI
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import SwiftUI

public struct CapsuleChip<Content: View, S: ShapeStyle>: View {
  
  let content: Content
  let backgroundStyle: S
  
  public init(backgroundStyle: S = .thinMaterial, @ViewBuilder content: () -> Content) {
    self.backgroundStyle = backgroundStyle
    self.content = content()
  }
  
  public var body: some View {
    content
      .padding(.horizontal, Insets.chipHorizontal)
      .padding(.vertical, Insets.chipVertical)
      .background(backgroundStyle, in: .capsule)
  }
  
}

