//
//  ModeCardView.swift
//  HomePresentation
//
//  Created by Ertan Yağmur on 9.03.2026.
//

import SharedUI
import SwiftUI

struct ModeCardView: View {
  
  @Environment(\.theme) private var theme
  
  let title: String
  let subtitle: String
  let systemImage: String
  let tint: Color
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      HStack {
        VStack(alignment: .leading, spacing: Spacing.medium) {
          Image(systemName: systemImage)
            .font(.system(size: IconSize.large))
            .foregroundStyle(tint)
          
          Text(title)
            .font(Typography.title)
          
          Text(subtitle)
            .font(Typography.caption)
            .foregroundStyle(.secondary)
        }
        
        Spacer()
        
        Image(systemName: "chevron.right")
          .font(.system(size: IconSize.medium))
          .foregroundStyle(theme.colors.secondary)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding()
      .background(CardBackground())
    }
    .buttonStyle(.plain)
  }
  
}

#Preview {
  ModeCardView(
    title: "Test",
    subtitle: "Button",
    systemImage: "music.note",
    tint: .accentColor,
    action: { }
  )
}
