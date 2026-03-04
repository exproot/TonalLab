//
//  EarTrainingView.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 20.02.2026.
//

import SwiftUI
import EarTrainingDomain

struct EarTrainingView: View {
  
  @ObservedObject var viewModel: EarTrainingViewModel
  
  var body: some View {
    VStack(spacing: 32) {
      
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
    .padding()
    .background(
      LinearGradient(
        colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.05)],
        startPoint: .top,
        endPoint: .bottom)
    )
    .task {
      await viewModel.start()
    }
  }
  
}

struct NoteButtonStyle: ButtonStyle {
  
  let note: PitchClass
  let selectedNote: PitchClass?
  let lastResult: Bool?
  let isEnabled: Bool
  
  func makeBody(configuration: Configuration) -> some View {
    let isSelected = selectedNote == note
    let backgroundColor: Color = {
      guard isSelected, let result = lastResult else {
        return isEnabled ? .accentColor : .gray.opacity(0.2)
      }
      
      return result ? .green : .red
    }()
    
    return configuration.label
      .font(.title2.bold())
      .frame(maxWidth: .infinity)
      .frame(minHeight: 56)
      .background(
        RoundedRectangle(cornerRadius: 18)
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

private struct PracticeHeaderView: View {
  
  let model: PracticeHeaderUIModel
  
  var body: some View {
    HStack {
      ModeBadgeView(model: model.modeBadge)
      
      Spacer()
      
      HStack(spacing: 6) {
        Image(systemName: "trophy.fill")
          .foregroundStyle(.yellow)
        
        Text("\(model.score)")
          .font(.subheadline.weight(.semibold))
      }
      .padding(.horizontal, 10)
      .padding(.vertical, 8)
      .background(.thinMaterial, in: .capsule)
    }
  }
  
}

private struct GameHeaderView: View {
  
  let model: GameHeaderUIModel
  
  private var answeredQuestions: Int {
    max(0, model.totalQuestions - model.remainingQuestions)
  }
  
  private var currentQuestionNumber: Int {
    model.remainingQuestions > 0
    ? min(model.totalQuestions, answeredQuestions + 1)
    : model.totalQuestions
  }
  
  private var progress: Double {
    Double(min(answeredQuestions, model.totalQuestions)) / Double(model.totalQuestions)
  }
  
  var body: some View {
    VStack(spacing: 16) {
      
      HStack {
        ModeBadgeView(model: model.modeBadge)
        
        Spacer()
        
        Text("Question \(currentQuestionNumber) / \(model.totalQuestions)")
          .font(.subheadline.weight(.semibold))
          .padding(.horizontal, 10)
          .padding(.vertical, 6)
      }
      
      ProgressView(value: progress)
      
      HStack {
        livesView
        Spacer()
        replaysView
        scoreView
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      .background(.ultraThinMaterial)
      .clipShape(RoundedRectangle(cornerRadius: 18))
      .overlay(
        RoundedRectangle(cornerRadius: 18)
          .strokeBorder(.separator.opacity(0.5), lineWidth: 1)
      )
    }
  }
  
  private var livesView: some View {
    HStack(spacing: 6) {
      ForEach(0..<model.totalLives, id: \.self) { i in
        Image(systemName: i < model.remainingLives ? "heart.fill" : "heart")
          .symbolRenderingMode(.hierarchical)
          .foregroundStyle(i < model.remainingLives ? .red : .secondary)
      }
    }
    .animation(.spring(response: 0.3), value: model.remainingLives)
    .padding(.horizontal, 10)
    .padding(.vertical, 8)
    .background(.thinMaterial, in: .capsule)
  }
  
  private var replaysView: some View {
    HStack(spacing: 4) {
      Image(systemName: "speaker.wave.2.fill")
      
      Text("\(model.remainingReplays) / \(model.totalReplays)")
    }
    .padding(.horizontal, 10)
    .padding(.vertical, 8)
    .background(.thinMaterial, in: .capsule)
  }
  
  private var scoreView: some View {
    HStack(spacing: 6) {
      Image(systemName: "trophy.fill")
        .foregroundStyle(.yellow)
      
      Text("\(model.score)")
        .font(.subheadline)
        .fontWeight(.semibold)
    }
    .padding(.horizontal, 10)
    .padding(.vertical, 8)
    .background(.thinMaterial, in: .capsule)
  }
  
}

private struct ModeBadgeView: View {
  
  let model: EarTrainingModeBadgeUIModel
  
  private var tint: Color {
    switch model.tint {
    case .green: .green
    case .orange: .orange
    }
  }
  
  var body: some View {
    HStack(spacing: 6) {
      Image(systemName: model.systemImage)
      
      Text(model.title)
        .font(.caption2.bold())
        .tracking(0.6)
    }
    .foregroundStyle(tint)
    .padding(.horizontal, 10)
    .padding(.vertical, 6)
    .background(tint.opacity(0.15), in: .capsule)
    .overlay(
      Capsule()
        .strokeBorder(tint.opacity(0.25), lineWidth: 1)
    )
  }
  
}

private struct NoteGridView: View {
  
  let selectedNote: PitchClass?
  let lastResult: Bool?
  let canAnswer: Bool
  let onTappingNote: (PitchClass) -> Void
  
  var body: some View {
    LazyVGrid(
      columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3),
      spacing: 16
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

private struct PhaseCardView: View {
  
  let phase: Phase
  let phaseText: String
  let phaseImageString: String
  let canReplay: Bool
  let onReplay: () -> Void
  
  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: phaseImageString)
        .font(.system(size: 28))
        .fontWeight(.semibold)
        .foregroundStyle(phaseColor)
        .frame(width: 48, height: 48)
        .rotationEffect(phase == .resolvingAnswer ? .degrees(180) : .zero)
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: phase)
      
      Text(phaseText)
        .font(.title3.bold())
        .multilineTextAlignment(.center)
        .frame(minHeight: 24)
      
      Button {
        onReplay()
      } label: {
        HStack {
          Image(systemName: "speaker.wave.2.fill")
          
          Text("Replay")
            .fontWeight(.semibold)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
        .background(
          Capsule()
            .fill(canReplay ? phaseColor : phaseColor.opacity(0.2))
            .shadow(color: phaseColor.opacity(0.4), radius: 6, y: 3)
        )
        .foregroundStyle(.white)
      }
      .disabled(!canReplay)
      
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerRadius: 18)
        .fill(backgroundGradient)
        .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
    )
    .animation(.easeInOut(duration: 0.25), value: phase)
    .scaleEffect(phase == .resolvingAnswer ? 1.02 : 1.0)
  }
  
  private var phaseColor: Color {
    switch phase {
    case .idle, .finished:
        .gray
    case .waitingForAnswer:
        .green
    case .resolvingAnswer:
        .orange
    }
  }
  
  private var backgroundGradient: LinearGradient {
    let base = phaseColor
    
    return LinearGradient(
      colors: [base.opacity(0.25), base.opacity(0.08)],
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
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
      actions: EarTrainingViewModelActions(showResult: { _, _ in })
    )
  )
}
