//
//  SceneDelegate.swift
//  DeliveryApp
//
//  Created by Artem Muho on 13.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

   var window: UIWindow?

   func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

      guard let windowScene = (scene as? UIWindowScene) else { return }
      window = UIWindow(windowScene: windowScene)
      let mainScreen = UINavigationController(rootViewController: ViewController())
      window?.rootViewController = mainScreen
      window?.makeKeyAndVisible()
   }
}

