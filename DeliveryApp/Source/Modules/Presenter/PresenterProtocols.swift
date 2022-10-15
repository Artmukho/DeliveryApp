//
//  PresenterProtocols.swift
//  DeliveryApp
//
//  Created by Artem Muho on 15.10.2022.
//

import Foundation

protocol MenuPresenterOutput {
   func getMenuModel()
   func getCategoryModel()
}

protocol MenuPresenterInput: AnyObject {
   func pullMenuModel(_ model: MenuModel)
   func pullCategoryModel(_ model: [[HeaderModel]])
}
