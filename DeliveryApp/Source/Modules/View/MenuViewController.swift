//
//  ViewController.swift
//  DeliveryApp
//
//  Created by Artem Muho on 13.10.2022.
//

import UIKit

class MenuViewController: UIViewController, MenuViewInput {
   
   // MARK: - Private properties
   
   private var selectedIndex = 0

   private var presenter: MenuViewOutput?
   
   private lazy var header: UIView = {
      var header = HeaderView(delegate: self)
      header.layer.shadowOffset = CGSize(width: 0, height: 5)
      header.layer.shadowColor = UIColor.black.cgColor
      header.layer.shadowOpacity = 0.1
      return header
   }()
   
   private let loacationLabel: UIButton = {
      var label = UIButton(type: .system)
      label.setTitle("Москва", for: .normal)
      return label
   }()
   
   private lazy var tableView: UITableView = {
      var table = UITableView(frame: .zero, style: .plain)
      table.delegate = self
      table.dataSource = self
      table.showsVerticalScrollIndicator = false
      table.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.identifier)
      return table
   }()
   
   // MARK: - Lifecycle
   
   init(presenter: MenuViewOutput) {
      super.init(nibName: nil, bundle: nil)
      self.presenter = presenter
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white
      setupHierarchy()
      setupLayout()
      setupNavigationBar()
      setupTabBar()
   }
   
   
   // MARK: - Private methods
   
   private func setupNavigationBar() {
      let appearnace = UINavigationBarAppearance()
      appearnace.backgroundColor = UIColor(named: "backgroundCol")
      appearnace.shadowColor = .clear
      navigationController?.navigationBar.standardAppearance = appearnace
      navigationController?.navigationBar.scrollEdgeAppearance = appearnace
      navigationController?.navigationBar.isTranslucent = false
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Москва", style: .plain, target: nil, action: nil)
   }
   
   private func setupTabBar() {
      tabBarController?.tabBar.backgroundColor = .white
      tabBarController?.tabBar.tintColor = UIColor(named: "tintColor")
      let tabBarAppearance = UITabBarAppearance()
      tabBarAppearance.backgroundColor = .white
      tabBarController?.tabBar.standardAppearance = tabBarAppearance
   }
   
   private func setupHierarchy() {
      view.addSubview(tableView)
      view.addSubview(header)
   }

   private func setupLayout() {
      header.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.equalTo(view.snp.leading)
         make.trailing.equalTo(view.snp.trailing)
         make.height.equalTo(200)
      }
      
      tableView.snp.makeConstraints { make in
         make.top.equalTo(header.snp.bottom)
         make.bottom.equalTo(view.snp.bottom)
         make.leading.equalTo(view.snp.leading)
         make.trailing.equalTo(view.snp.trailing)
      }
   }
   
   private func listLayout() -> UICollectionViewCompositionalLayout {
      return UICollectionViewCompositionalLayout { section, environment in
         let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
         let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
         let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
         group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
         
         let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
         let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                  elementKind: UICollectionView.elementKindSectionHeader,
                                                                  alignment: .top)
         
         let section = NSCollectionLayoutSection(group: group)
         section.boundarySupplementaryItems = [header]
         return section
      }
   }
   
   // MARK: - Protocols methods
   
   func reloadData() {
      tableView.reloadData()
   }
}


// MARK: - TableView delegate methods

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let index = indexPath.row
      guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemCell.identifier, for: indexPath) as? MenuItemCell else { return UITableViewCell() }
      presenter?.getImage(index: indexPath, callback: { data in
         guard let image = UIImage(data: data) else { return }
         cell.setupImage(image: image)
      })
      if let name = presenter?.getItemName(index: index),
         let description = presenter?.getItemDesription(index: index),
         let price = presenter?.getItemPrice(index: index) {
         cell.setupCell(name: name, descriprion: description, price: price)
      }
      return cell
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      presenter?.getMenuRowsCount() ?? 0
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return view.frame.height / 4
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
   }
}

extension MenuViewController: UIScrollViewDelegate {
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let maxOffset = header.frame.height
      let yOffset = scrollView.contentOffset.y
      let delta = maxOffset - yOffset

      if delta >= 50 && yOffset > 0{
         header.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-yOffset)
         }
      }
      
      if delta >= maxOffset {
         header.frame.origin.y = 0
         scrollView.snp.updateConstraints { make in
            make.top.equalTo(header.snp.bottom)
         }
      }
      
      if delta < 50 {
         header.frame.origin.y = -150
         scrollView.frame.origin.y = -150 + maxOffset
      }
   }
}

extension MenuViewController: CategoryDelegate {
   func getCellName(index: IndexPath) -> String {
      presenter?.getCategoryName(index: index) ?? ""
   }
   
   func getCellType(index: IndexPath) -> HeaderModel.DataType {
      presenter?.getHeaderType(index: index) ?? .image
   }
   
   func getRowsCount(index: Int) -> Int {
      presenter?.getCategoryRowsCount(index: index) ?? 0
   }
   
   func getSectionCount() -> Int {
      presenter?.getCategorySectionCount() ?? 0
   }
   
   func scrollToCategory(index: IndexPath) {
      if let numberOfRows = presenter?.getCategoryIndex(index) {
         tableView.scrollToRow(at: numberOfRows, at: .top, animated: true)
      }
   }
}
