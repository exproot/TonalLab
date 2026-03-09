//
//  EarTrainingView.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import SharedUI
import SwiftUI
import EarTrainingDomain

struct EarTrainingView: View {
  
  @ObservedObject var viewModel: EarTrainingViewModel
  
  var body: some View {
    
    ScreenContainer {
      VStack(spacing: Spacing.extraLarge) {
        
        switch viewModel.headerUIModel {
        case .practice(let model):
          PracticeHeaderView(model: model)
        case .game(let model):
          GameHeaderView(model: model)
        }
        
        PhaseCardView(
          phase: viewModel.state.phase,
          phaseText: viewModel.phaseText,
          phaseImageString: viewModel.phaseImageString,
          canReplay: viewModel.canReplay
        ) {
          viewModel.replay()
        }
        
        if viewModel.state.currentQuestion != nil {
          NoteGridView(
            selectedNote: viewModel.selectedNote,
            lastResult: viewModel.state.lastResult,
            canAnswer: viewModel.canAnswerQuestion
          ) { note in
            viewModel.submit(note)
          }
        }
        
        Spacer()
      }
    }
    .task {
      await viewModel.start()
    }
  }
  
}

struct NoteButtonStyle: ButtonStyle {
  
  @Environment(\.theme) private var theme
  
  let note: PitchClass
  let selectedNote: PitchClass?
  let lastResult: Bool?
  let isEnabled: Bool
  
  func makeBody(configuration: Configuration) -> some View {
    let isSelected = selectedNote == note
    let backgroundColor: Color = {
      guard isSelected, let result = lastResult else {
        return isEnabled
        ? theme.colors.primary
        : theme.colors.semantic.idle.opacity(0.2)
      }
      
      return result ? theme.colors.semantic.success : theme.colors.semantic.error
    }()
    
    return configuration.label
      .font(.title2.bold())
      .frame(maxWidth: .infinity)
      .frame(minHeight: 56)
      .background(
        RoundedRectangle(cornerRadius: Radius.large)
          .fill(backgroundColor)
          .shadow(
            color: isEnabled ? .black.opacity(0.15) : .clear,
            radius: 4,
            y: 4
          )
      )
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
      .animation(.easeInOut(duration: 0.2), value: backgroundColor)
      .foregroundStyle(.white)
  }
  
}

#Preview {
  let mockMode = EarTrainingMode.game(totalQuestions: 10, totalLives: 3, totalAudioReplays: 3)
  let mockContext = EarTrainingContext(mode: mockMode)
  let mockState = EarTrainingState(
    currentQuestion: EarTrainingQuestion(pitchClass: .a),
    score: 0,
    lastResult: false,
    phase: .waitingForAnswer,
    remainingQuestions: 10,
    remainingLives: 3,
    remainingReplays: 3,
    context: mockContext
  )
  let mockSession = MockEarTrainingSession(mockState: mockState)
  
  EarTrainingView(
    viewModel: EarTrainingViewModel(
      session: mockSession,
      actions: EarTrainingViewModelActions(showResult: { _ in })
    )
  )
}
