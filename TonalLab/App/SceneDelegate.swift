//
//  SceneDelegate.swift
//  TonalLab
//
//  Created by Ertan Yağmur on 13.02.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  let appDIContainer = AppDIContainer()
  
  var appFlowCoordinator: AppFlowCoordinator?
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    let navigationController = UINavigationController()
    
    window.rootViewController = navigationController
    appFlowCoordinator = AppFlowCoordinator(
      navigationController: navigationController,
      appDIContainer: appDIContainer
    )
    appFlowCoordinator?.start()
    
    self.window = window
    window.makeKeyAndVisible()
  }

}

