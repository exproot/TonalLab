//
//  ScreenContainer.swift
//  SharedUI
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import SwiftUI

public struct ScreenContainer<Content: View>: View {
  
  @Environment(\.theme) private var theme
  
  let content: Content
  
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  public var body: some View {
  
    ZStack {
      LinearGradient(
        colors: theme.colors.backgroundGradient,
        startPoint: .top,
        endPoint: .bottom
      )
      .ignoresSafeArea()
      
      content
        .padding(Spacing.medium)
    }
  }
  
}
