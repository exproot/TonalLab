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
    navigationItem.hidesBackButton = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.setNavigationBarHidden(true, animated: true)
    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    navigationController?.interactivePopGestureRecognizer?.isEnabled = true
  }
  
  // MARK: View Setup
  private func setupView() {
    title = "Training Result"
  }
  
}
