//
//  NetworkManager.swift
//  DeliveryApp
//
//  Created by Artem Muho on 14.10.2022.
//

import Foundation

protocol NetworkService {
   func fetchData(complition: @escaping (MenuModel?) -> Void)
   func downloadImage(url: String, complition: @escaping (Data) -> Void)
}

class NetworkManager: NetworkService {
   private let manager = URLSession.shared
   private let url = URL(string: "https://run.mocky.io/v3/007b6abc-a5bd-4315-8915-9a957733e7a1")

   func fetchData(complition: @escaping (MenuModel?) -> Void) {
      let decoder = JSONDecoder()
      guard let path = url else { return }
      var request = URLRequest(url: path)
      request.httpMethod = "GET"

      manager.dataTask(with: request) { data, response, error in
         if let error = error as? NSError {
            print("Ошибка код: \(error.code)", error.localizedDescription)
         }
         
         if let response = response as? HTTPURLResponse {
            print("Статус код: \(response.statusCode)")
         }
         guard let data = data else { return }
         let decodeData = try? decoder.decode(MenuModel.self, from: data)
         complition(decodeData)
      }.resume()
   }
   
   func downloadImage(url: String, complition: @escaping (Data) -> Void) {
      guard let path = URL(string: url) else { return }
      manager.dataTask(with: path) { data, response, error in
         guard let data = data else { return }
         DispatchQueue.main.async {
            complition(data)
         }
      }.resume()
   }
}
