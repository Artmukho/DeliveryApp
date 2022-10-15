//
//  HeaderView.swift
//  DeliveryApp
//
//  Created by Artem Muho on 14.10.2022.
//

import UIKit
import SnapKit



class HeaderView: UIView {
   
   var delegate: CategoryDelegate?
   private lazy var model = HeaderModel.getModel
   private var selectedIndex = 0
   
   private lazy var categories: UICollectionView = {
      let layout = setupLayoutCollection()
      let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collection.backgroundColor = UIColor(named: "backgroundCol")
      collection.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
      collection.register(SpecialOfferCell.self, forCellWithReuseIdentifier: SpecialOfferCell.identifier)
      collection.dataSource = self
      collection.delegate = self
      return collection
   }()
   
   // MARK: - Initializer
   
   init(delegate: CategoryDelegate) {
      super.init(frame: .zero)
      self.delegate = delegate
      setupHierarchy()
      setupLayout()
      backgroundColor = UIColor(named: "backgroundCol")
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   // MARK: - Private methods
   
   private func setupLayoutCollection() -> UICollectionViewCompositionalLayout {
      return UICollectionViewCompositionalLayout { (section, _) in
         switch section {
         case 0:
            return self.setupOfferLayout()
         default:
            return self.setupCategoriesLayout()
         }
      }
      
   }
   
   private func setupCategoriesLayout() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                            heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                             heightDimension: .absolute(50))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
      group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      
      return section
   }
   
   private func setupOfferLayout() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                            heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                             heightDimension: .fractionalHeight(0.7))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
      group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      
      return section
   }
   
   private func setupHierarchy() {
      addSubview(categories)
   }
   
   private func setupLayout() {
      categories.snp.makeConstraints({ make in
         make.top.bottom.trailing.leading.equalToSuperview()
      })
   }
}

// MARK: - Collection data source methods

extension HeaderView: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      delegate?.getRowsCount(index: section) ?? 0
   }
   
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      delegate?.getSectionCount() ?? 0
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cellType = delegate?.getCellType(index: indexPath)
      let name = delegate?.getCellName(index: indexPath) ?? ""
      switch cellType {
      case .image:
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialOfferCell.identifier, for: indexPath) as? SpecialOfferCell else { return UICollectionViewCell() }
         cell.configCell(with: name)
         return cell
      case .title:
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as? CategoriesCell else { return UICollectionViewCell() }
         cell.configureCell(text: name)
         selectedIndex == indexPath.row ? cell.selected() : cell.deselected()
         return cell
      case .none:
         return UICollectionViewCell()
      }
   }
}

// MARK: - Collection delegate methods

extension HeaderView: UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      if indexPath.section > 0 {
         delegate?.scrollToCategory(index: indexPath)
         selectedIndex = indexPath.row
      }
      collectionView.deselectItem(at: indexPath, animated: true)
      collectionView.reloadData()
   }
}
