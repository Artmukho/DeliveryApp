//
//  MenuPresenter.swift
//  DeliveryApp
//
//  Created by Artem Muho on 15.10.2022.
//

import UIKit

class MenuPresenter: MenuViewOutput, MenuPresenterInput {
   
   private var headerModel: [[HeaderModel]]?
   private var mainModel: MenuModel?
   var interactor: MenuInteractor? {
      didSet {
         interactor?.getCategoryModel()
         interactor?.getMenuModel()
      }
   }
   weak var view: MenuViewInput?
   
   // MARK: - MenuViewOutput methods
   
   func getItemName(index: Int) -> String? {
      mainModel?.items[index].name
   }
   
   func getItemDesription(index: Int) -> String? {
      mainModel?.items[index].description
   }
   
   func getItemPrice(index: Int) -> Int? {
      mainModel?.items[index].shopItem.first?.price
   }
   
   func getCategoryIndex(_ categoryIndex: IndexPath) -> IndexPath {
      let category = headerModel?[categoryIndex.section][categoryIndex.row].category
      let index = mainModel?.items.firstIndex(where: { $0.category == category}) ?? 0
      return IndexPath(row: index, section: 0)
   }
   
   func getMenuRowsCount() -> Int? {
      mainModel?.items.count
   }
   
   func getImage(index: IndexPath, callback: @escaping (Data) -> Void) {
      let url = mainModel?.items[index.row].image.url
      interactor?.fetchImage(url: url ?? "") { data in
         callback(data)
      }
   }
   
   func getHeaderType(index: IndexPath) -> HeaderModel.DataType {
      headerModel?[index.section][index.row].type ?? .image
   }
   
   func getCategoryRowsCount(index: Int) -> Int {
      headerModel?[index].count ?? 0
   }
   
   func getCategorySectionCount() -> Int {
      headerModel?.count ?? 0
   }
   
   func getCategoryName(index: IndexPath) -> String {
      headerModel?[index.section][index.row].name ?? ""
   }
   
   // MARK: - MenuPresenterInput methods

   func pullMenuModel(_ model: MenuModel) {
      mainModel = model
      DispatchQueue.main.async { [weak self] in
         self?.view?.reloadData()
      }
   }
   
   func pullCategoryModel(_ model: [[HeaderModel]]) {
      headerModel = model
   }
   
}
