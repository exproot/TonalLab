//
//  SemanticColors.swift
//  SharedUI
//
//  Created by Ertan Yağmur on 9.03.2026.
//

import SwiftUI

public struct SemanticColors: Sendable {
  
  public let success: Color
  public let warning: Color
  public let error: Color
  public let info: Color
  public let idle: Color
  
  public init(
    success: Color,
    warning: Color,
    error: Color,
    info: Color,
    idle: Color
  ) {
    self.success = success
    self.warning = warning
    self.error = error
    self.info = info
    self.idle = idle
  }
  
}
