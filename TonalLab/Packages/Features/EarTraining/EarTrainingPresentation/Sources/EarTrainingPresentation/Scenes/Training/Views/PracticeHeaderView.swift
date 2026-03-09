//
//  PracticeHeaderView.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import SharedUI
import SwiftUI

struct PracticeHeaderView: View {
  
  @Environment(\.theme) private var theme
  
  let model: PracticeHeaderUIModel
  
  var body: some View {
    HStack {
      ModeBadgeView(model: model.modeBadge)
      
      Spacer()
      
      CapsuleChip {
        HStack(spacing: Spacing.small) {
          Image(systemName: "trophy.fill")
            .foregroundStyle(theme.colors.palette.accentSecondary)
          
          Text("\(model.score)")
            .font(Typography.subtitle)
            .fontWeight(.semibold)
        }
      }
    }
  }
  
}

#Preview {
  PracticeHeaderView(
    model: .init(
      modeBadge: .init(title: "PRACTICE", systemImage: "infinity", tint: .practice),
      score: 5)
  )
}
