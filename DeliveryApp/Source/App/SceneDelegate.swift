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
      
      let tabBarController = UITabBarController()

      guard let windowScene = (scene as? UIWindowScene) else { return }
      window = UIWindow(windowScene: windowScene)
      let assembler = Assembler()
      let mainScreen = UINavigationController(rootViewController: assembler.getMainModule())
      mainScreen.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "MenuIcon"), tag: 0)
      
      let conatcScreen = EmptyViewController()
      conatcScreen.tabBarItem = UITabBarItem(title: "Contacts", image: UIImage(named: "ContactIcon"), tag: 1)
      
      let profileScreen = EmptyViewController()
      profileScreen.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "ProfileIcon"), tag: 2)
      
      let busketScreen = EmptyViewController()
      busketScreen.tabBarItem = UITabBarItem(title: "Busket", image: UIImage(named: "BasketIcon"), tag: 3)
      
      tabBarController.setViewControllers([mainScreen, conatcScreen, profileScreen, busketScreen], animated: true)
      window?.rootViewController = tabBarController
      window?.makeKeyAndVisible()
   }
}

