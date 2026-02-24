//
//  TrainingHostingController.swift
//  TrainingFeaturePresentation
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import SharedUI

final class TrainingHostingController: HostingController<TrainingView> {
  
  // MARK: ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: View Setup
  func setupView() {
    title = "Training"
  }
  
}
