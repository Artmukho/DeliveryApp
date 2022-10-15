//
//  Assembler.swift
//  DeliveryApp
//
//  Created by Artem Muho on 15.10.2022.
//

import UIKit

class Assembler {
   func getMainModule() -> UIViewController {
      let manager = NetworkManager()
      let presenter = MenuPresenter()
      let interactor = MenuInteractor(networkManager: manager, presenter: presenter)
      let view = MenuViewController(presenter: presenter)
      
      presenter.interactor = interactor
      presenter.view = view
//      interactor.presenter = presenter
      
      return view
   }
}
