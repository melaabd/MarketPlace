//
//  ProductsSearchVC.swift
//  MarketPlace
//
//  Created by melaabd on 3/6/22.
//

import UIKit

class ProductsSearchVC: BaseTableVC {

    lazy var searchController:UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.accessibilityTraits = .staticText
        search.searchBar.isAccessibilityElement = true
        search.searchBar.accessibilityIdentifier = AccessibilityIds.productsSearchSearchBarId
        search.searchBar.placeholder = Str.searchBarPlaceholder
        search.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 16)
        search.searchBar.tintColor = .prime
        return search
    }()
    
    override func viewDidLoad() {
        setUpBG(title: Str.searchVCTitle)
        super.viewDidLoad()
    }

    // MARK: - Setup Views
    override func setupViews() {
        super.setupViews()
        
        navigationController?.navigationBar.accessibilityIdentifier = AccessibilityIds.productsSearchNavigationBarId
        setupSearchBar()
        tableView.register(ProductTVCell.self, forCellReuseIdentifier: ProductTVCell.identifier)
    }
    
    /// intialize search controller with setting properties
    private func setupSearchBar() {
        navigationItem.searchController = searchController
    }
}

// MARK: - UITableViewDataSource
extension ProductsSearchVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let noOfRows = 0
        (noOfRows == 0) ? tableView.setEmptyView("No Results") : tableView.setEmptyView()
        return noOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTVCell.identifier, for: indexPath) as? ProductTVCell ?? ProductTVCell()
            return cell
    }

}
