//
//  AppAnimation.swift
//  SharedUI
//
//  Created by Ertan Yağmur on 6.03.2026.
//

import SwiftUI

public enum AppAnimation {
  
  public static let press = Animation.easeInOut(duration: 0.2)
  public static let card = Animation.easeInOut(duration: 0.25)
  public static let spring = Animation.spring(response: 0.4, dampingFraction: 0.7)
  
}
