//
//  HomeViewModel.swift
//  HomePresentation
//
//  Created by Ertan Yağmur on 9.03.2026.
//

import Foundation

public enum HomeTrainingSelection {
  case practice
  case game
}

struct HomeViewModelActions {
  let startTraining: (HomeTrainingSelection) -> Void
}

@MainActor
final class HomeViewModel {
  
  private let actions: HomeViewModelActions
  
  init(actions: HomeViewModelActions) {
    self.actions = actions
  }
  
  func didTapStartPractice() {
    actions.startTraining(.practice)
  }
  
  func didTapStartGame() {
    actions.startTraining(.game)
  }
  
}
