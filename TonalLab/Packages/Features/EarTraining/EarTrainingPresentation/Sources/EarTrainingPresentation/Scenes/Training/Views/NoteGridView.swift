//
//  NoteGridView.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import EarTrainingDomain
import SharedUI
import SwiftUI

struct NoteGridView: View {
  
  let selectedNote: PitchClass?
  let lastResult: Bool?
  let canAnswer: Bool
  let onTappingNote: (PitchClass) -> Void
  
  var body: some View {
    LazyVGrid(
      columns: Array(
        repeating: GridItem(.flexible(), spacing: Spacing.large),
        count: 3
      ),
      spacing: Spacing.large
    ) {
      ForEach(Scale.cMajor.notes, id: \.self) { note in
        Button(note.displayName) {
          onTappingNote(note)
        }
        .buttonStyle(
          NoteButtonStyle(
            note: note,
            selectedNote: selectedNote,
            lastResult: lastResult,
            isEnabled: canAnswer
          )
        )
        .disabled(!canAnswer)
      }
    }
  }
  
}

#Preview {
  NoteGridView(
    selectedNote: .a,
    lastResult: nil,
    canAnswer: true,
    onTappingNote: { _ in })
}
