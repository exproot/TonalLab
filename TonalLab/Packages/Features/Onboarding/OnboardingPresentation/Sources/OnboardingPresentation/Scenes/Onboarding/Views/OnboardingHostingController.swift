//
//  OnboardingHostingController.swift
//  OnboardingPresentation
//
//  Created by Ertan Yağmur on 28.03.2026.
//

import SharedUI

final class OnboardingHostingController: HostingController<OnboardingView> {
  
  // MARK: ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  // MARK: View Setup
  func setupView() {
    title = "Onboarding"
  }
  
}
