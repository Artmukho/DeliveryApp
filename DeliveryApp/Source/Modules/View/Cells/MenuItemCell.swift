//
//  MenuItemCell.swift
//  DeliveryApp
//
//  Created by Artem Muho on 13.10.2022.
//

import UIKit

class MenuItemCell: UITableViewCell {
   
   // MARK: - Properties
   
   static let identifier = "MenuItemCell"
   
   private lazy var picture = UIImageView()
   
   private lazy var title: UILabel = {
      var title = UILabel()
      title.text = "Пепперони"
      title.textColor = .black
      title.font = .systemFont(ofSize: 20, weight: .bold)
      return title
   }()

   private var descriptionLabel: UILabel = {
      let label = UILabel()
      label.font = .systemFont(ofSize: 14)
      label.textColor = .lightGray
      label.numberOfLines = 4
      return label
   }()
   
   private var priceLabel: UILabel = {
      let label = UILabel()
      label.textAlignment = .center
      label.textColor = UIColor(named: "tintColor")
      label.layer.borderColor = UIColor(named: "tintColor")?.cgColor
      label.layer.borderWidth = 1
      label.layer.cornerRadius = 6
      return label
   }()
   
   // MARK: - Initialization
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupHierarchy()
      setupLayout()
      backgroundColor = .white
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   // MARK: - Public methods
   
   func setupCell(name: String, descriprion: String, price: Int) {
      title.text = name
      descriptionLabel.text = descriprion
      priceLabel.text = "от \(price) р"
   }
   
   func setupImage(image: UIImage) {
      picture.image = image
   }
   
   // MARK: - Private methods
   
   private func setupHierarchy() {
      addSubview(priceLabel)
      addSubview(picture)
      addSubview(title)
      addSubview(descriptionLabel)
   }
   
   private func setupLayout() {
      picture.snp.makeConstraints { make in
         make.width.height.equalTo(130)
         make.centerY.equalToSuperview()
         make.leading.equalToSuperview().offset(10)
      }
      
      title.snp.makeConstraints { make in
         make.top.equalTo(picture.snp.top)
         make.leading.equalTo(picture.snp.trailing).offset(20)
         make.trailing.equalTo(self.snp.trailing).offset(-20)
      }
      
      descriptionLabel.snp.makeConstraints { make in
         make.trailing.leading.equalTo(title)
         make.top.equalTo(title.snp.bottom)
      }
      
      priceLabel.snp.makeConstraints { make in
         make.width.equalTo(80)
         make.height.equalTo(30)
         make.bottom.equalTo(picture.snp.bottom)
         make.trailing.equalTo(title.snp.trailing)
      }
   }
   
   override func prepareForReuse() {
      picture.image = nil
      title.text = nil
      descriptionLabel.text = nil
      priceLabel.text = nil
   }
}
