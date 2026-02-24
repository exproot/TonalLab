//
//  ReductionResult.swift
//  TrainingFeatureDomain
//
//  Created by Ertan Yağmur on 23.02.2026.
//

import Foundation

public struct ReductionResult: Sendable {
  public let state: TrainingState
  public let events: [TrainingEvent]
}
