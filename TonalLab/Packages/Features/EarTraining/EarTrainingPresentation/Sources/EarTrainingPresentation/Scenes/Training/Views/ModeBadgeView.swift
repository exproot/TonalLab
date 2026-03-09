//
//  ModeBadgeView.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import SharedUI
import SwiftUI

struct ModeBadgeView: View {
  
  @Environment(\.theme) private var theme
  
  let model: EarTrainingModeBadgeUIModel
  
  private var tint: Color {
    switch model.tint {
    case .practice: theme.colors.palette.brand
    case .game: theme.colors.palette.accent
    }
  }
  
  var body: some View {
    
    CapsuleChip(backgroundStyle: tint.opacity(0.15)) {
      HStack(spacing: Spacing.small) {
        Image(systemName: model.systemImage)
        
        Text(model.title)
          .font(.caption2.bold())
          .tracking(0.6)
      }
      .foregroundStyle(tint)
    }
    .overlay(
      Capsule()
        .strokeBorder(tint.opacity(0.25), lineWidth: 1)
    )
  }
  
}

#Preview {
  ModeBadgeView(model: .init(title: "PRACTICE", systemImage: "infinity", tint: .practice))
}
