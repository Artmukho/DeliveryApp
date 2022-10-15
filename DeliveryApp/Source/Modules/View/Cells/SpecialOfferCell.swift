//
//  SpecialOfferCell.swift
//  DeliveryApp
//
//  Created by Artem Muho on 14.10.2022.
//

import UIKit

class SpecialOfferCell: UICollectionViewCell {
   
   static let identifier = "SpecialOfferCell"
   
   private var picture: UIImageView = {
      var image = UIImageView()
      image.layer.cornerRadius = 10
      image.layer.masksToBounds = true
      image.translatesAutoresizingMaskIntoConstraints = false
      return image
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      addSubview(picture)
      setupLayout()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   private func setupLayout() {
      picture.snp.makeConstraints { make in
         make.top.bottom.leading.trailing.equalToSuperview()
      }
   }
   
   func configCell(with image: String) {
      picture.image = UIImage(named: image)
   }
}
