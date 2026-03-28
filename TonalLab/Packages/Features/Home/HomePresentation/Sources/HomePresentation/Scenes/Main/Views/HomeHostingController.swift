//
//  HomeHostingController.swift
//  HomePresentation
//
//  Created by Ertan Yağmur on 9.03.2026.
//

import SharedUI

final class HomeHostingController: HostingController<HomeView> {
  
  // MARK: ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: View Setup
  func setupView() {
    title = "Home"
  }
  
}
