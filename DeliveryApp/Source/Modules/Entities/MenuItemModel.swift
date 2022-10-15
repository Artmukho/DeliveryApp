//
//  MenuItemModel.swift
//  DeliveryApp
//
//  Created by Artem Muho on 15.10.2022.
//

import Foundation

struct MenuModel: Decodable {
   let items: [MenuItem]
}

struct MenuItem: Decodable {
   let name: String
   let description: String
   let category: Int
   let image: Image
   let shopItem: [ShopItem]
   
   enum CodingKeys: String, CodingKey {
      case name
      case description
      case category
      case image
      case shopItem = "shoppingItems"
   }
   
   init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      name = try container.decode(String.self, forKey: .name)
      description = try container.decode(String.self, forKey: .description)
      category = try container.decode(Int.self, forKey: .category)
      image = try container.decode(Image.self, forKey: .image)
      shopItem = try container.decode([ShopItem] .self, forKey: .shopItem)
   }
}

struct Image: Decodable {
   let url: String
}

struct ShopItem: Decodable {
   let price: Int
}
