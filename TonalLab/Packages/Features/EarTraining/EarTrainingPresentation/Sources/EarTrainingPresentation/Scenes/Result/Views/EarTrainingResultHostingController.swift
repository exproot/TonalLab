//
//  EarTrainingResultHostingController.swift
//  EarTrainingPresentation
//
//  Created by Ertan Yağmur on 5.03.2026.
//

import SharedUI

final class EarTrainingResultHostingController: HostingController<EarTrainingResultView> {
  
  // MARK: ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: View Setup
  func setupView() {
    title = "Result"
  }
  
}
