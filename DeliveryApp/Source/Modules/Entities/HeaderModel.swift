//
//  HeaderModel.swift
//  DeliveryApp
//
//  Created by Artem Muho on 14.10.2022.
//

import Foundation

struct HeaderModel {
   var name: String
   var type: DataType
   
   var category: Int {
      switch self.name {
      case "Комбо":
         return 100
      case "Пицца":
         return 1
      case "Закуски":
         return 3
      case "Десреты":
         return 6
      case "Напитки":
         return 2
      case "Другое":
         return 5
      default:
         return 100
      }
   }
   
   enum DataType {
      case image
      case title
   }
   
   static let getModel = [[HeaderModel(name: "60min", type: .image),
                           HeaderModel(name: "sale", type: .image),
                           HeaderModel(name: "specialOffer", type: .image),
                           HeaderModel(name: "specialSale", type: .image)],
                          [HeaderModel(name: "Комбо", type: .title),
                           HeaderModel(name: "Закуски", type: .title),
                           HeaderModel(name: "Десреты", type: .title),
                           HeaderModel(name: "Напитки", type: .title),
                           HeaderModel(name: "Другое", type: .title),
                           HeaderModel(name: "Пицца", type: .title)]]
}
