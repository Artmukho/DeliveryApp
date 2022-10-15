//
//  MenuInteractor.swift
//  DeliveryApp
//
//  Created by Artem Muho on 15.10.2022.
//

import Foundation

class MenuInteractor: MenuPresenterOutput {
   
   private let networkManager: NetworkService?
   private weak var presenter: MenuPresenterInput?
   
   init(networkManager: NetworkManager, presenter: MenuPresenterInput) {
      self.networkManager = networkManager
      self.presenter = presenter
   }
   
   func getCategoryModel() {
      let model = [[HeaderModel(name: "60min", type: .image),
                     HeaderModel(name: "sale", type: .image),
                     HeaderModel(name: "specialOffer", type: .image),
                     HeaderModel(name: "specialSale", type: .image)],
                    [HeaderModel(name: "Комбо", type: .title),
                     HeaderModel(name: "Закуски", type: .title),
                     HeaderModel(name: "Десреты", type: .title),
                     HeaderModel(name: "Напитки", type: .title),
                     HeaderModel(name: "Другое", type: .title),
                     HeaderModel(name: "Пицца", type: .title)]]
      presenter?.pullCategoryModel(model)
   }
   
   func getMenuModel() {
      networkManager?.fetchData { [weak self] data in
         guard let model = data else { return }
         self?.presenter?.pullMenuModel(model)
      }
   }
   
   func fetchImage(url: String, callback: @escaping (Data) -> Void) {
      networkManager?.downloadImage(url: url) { result in
         callback(result)
      }
   }
}
