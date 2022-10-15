//
//  CategoriesCell.swift
//  DeliveryApp
//
//  Created by Artem Muho on 13.10.2022.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
   static var identifier = "CategoriesCell"
   
   private var title: UILabel = {
      let label = UILabel()
      label.font = .systemFont(ofSize: 16)
      label.textColor = UIColor(named: "tintColor")?.withAlphaComponent(0.4)
      label.textAlignment = .center
      return label
   }()
   
   override init(frame: CGRect) {
      super.init(frame: .infinite)
      setupHierarchy()
      setupLayout()
      setupLayer()
   }

   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   func configureCell(text: String) {
      title.text = text
   }
   
   func selected() {
      layer.backgroundColor = UIColor(named: "tintColor")?.withAlphaComponent(0.2).cgColor
      title.textColor = UIColor(named: "tintColor")
      title.font = .systemFont(ofSize: 16, weight: .bold)
      layer.borderWidth = 0
   }
   
   func deselected() {
      layer.backgroundColor = UIColor.clear.cgColor
      title.textColor = UIColor(named: "tintColor")?.withAlphaComponent(0.4)
      title.font = .systemFont(ofSize: 16)
      layer.borderWidth = 2
   }
   
   private func setupHierarchy() {
      addSubview(title)
   }
   
   private func setupLayer() {
      layer.cornerRadius = 16
      layer.borderColor = UIColor(named: "tintColor")?.withAlphaComponent(0.2).cgColor
      layer.borderWidth = 2
   }
   
   private func setupLayout() {
      title.snp.makeConstraints { make in
         make.center.equalToSuperview()
         make.height.width.equalToSuperview()
      }
   }
}
