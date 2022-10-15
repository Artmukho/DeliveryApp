//
//  EmptyView.swift
//  DeliveryApp
//
//  Created by Artem Muho on 14.10.2022.
//

import UIKit

class EmptyViewController: UIViewController {
   
   private var emptyTitle: UILabel = {
      var label = UILabel()
      label.text = "In progress..."
      label.font = .systemFont(ofSize: 24, weight: .bold)
      return label
   }()
   
   override func viewDidLoad() {
      view.backgroundColor = .white
      view.addSubview(emptyTitle)
      setupLabel()
   }
   
   private func setupLabel() {
      emptyTitle.snp.makeConstraints { make in
         make.center.equalToSuperview()
      }
   }
}
