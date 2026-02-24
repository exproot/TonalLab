//
//  TrainingView.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import SwiftUI
import TrainingFeatureDomain

struct TrainingView: View {
  
  @ObservedObject var viewModel: TrainingViewModel
  
  var body: some View {
    VStack(spacing: 24) {
      Text("Score: \(viewModel.state.score)")
        .font(.title)
      
      if let result = viewModel.state.lastResult {
        Text(result ? "Correct" : "Wrong")
          .font(.headline)
      }
      
      if viewModel.state.currentQuestion != nil {
        noteGrid
      }
    }
    .task {
      await viewModel.start()
    }
    .padding()
  }
  
  private var noteGrid: some View {
    LazyVGrid(
      columns: Array(repeating: GridItem(.flexible()), count: 3),
      spacing: 12
    ) {
      ForEach(Scale.cMajor.notes, id: \.self) { note in
        Button(note.displayName) {
          viewModel.submit(note)
        }
        .buttonStyle(.borderedProminent)
      }
    }
  }
  
}
