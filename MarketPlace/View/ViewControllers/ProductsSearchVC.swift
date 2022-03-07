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
    }
    
    /// intialize search controller with setting properties
    private func setupSearchBar() {
        
        navigationItem.searchController = searchController
    }
}
