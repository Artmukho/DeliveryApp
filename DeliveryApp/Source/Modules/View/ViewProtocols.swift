//
//  ViewProtocols.swift
//  DeliveryApp
//
//  Created by Artem Muho on 15.10.2022.
//

import Foundation

protocol MenuViewOutput {
   func getItemName(index: Int) -> String?
   func getItemDesription(index: Int) -> String?
   func getItemPrice(index: Int) -> Int?
   func getCategoryIndex(_ categoryIndex: IndexPath) -> IndexPath
   func getMenuRowsCount() -> Int?
   func getImage(index: IndexPath, callback: @escaping (Data) -> Void)
   func getCategoryRowsCount(index: Int) -> Int
   func getCategorySectionCount() -> Int
   func getHeaderType(index: IndexPath) -> HeaderModel.DataType
   func getCategoryName(index: IndexPath) -> String
}

protocol MenuViewInput: AnyObject {
   func reloadData()
}

protocol CategoryDelegate {
   func scrollToCategory(index: IndexPath)
   func getSectionCount() -> Int
   func getRowsCount(index: Int) -> Int
   func getCellType(index: IndexPath) -> HeaderModel.DataType
   func getCellName(index: IndexPath) -> String
}
