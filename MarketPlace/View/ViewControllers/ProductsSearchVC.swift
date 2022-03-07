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
        search.delegate = self
        search.searchBar.delegate = self
        search.searchBar.accessibilityTraits = .staticText
        search.searchBar.isAccessibilityElement = true
        search.searchBar.accessibilityIdentifier = AccessibilityIds.productsSearchSearchBarId
        search.searchBar.placeholder = Str.searchBarPlaceholder
        search.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 16)
        search.searchBar.tintColor = .prime
        return search
    }()
    
    
    private var productsSearchVM: ProductsSearchVM?
    
    override func viewDidLoad() {
        setUpBG(title: Str.searchVCTitle)
        super.viewDidLoad()
        
        productsSearchVM = ProductsSearchVM()
        productsSearchVM?.alertDelegate = self
        configureCompletions()
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
        GCD.onMain { [weak self] in
            self?.searchController.isActive = true
        }
    }
}

// MARK: - UITableViewDataSource
extension ProductsSearchVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let noOfRows = productsSearchVM?.productsVMs.count ?? 0
        (noOfRows == 0) ? tableView.setEmptyView("No Results") : tableView.setEmptyView()
        return noOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTVCell.identifier, for: indexPath) as? ProductTVCell ?? ProductTVCell()
        let cellVM = productsSearchVM?.productsVMs[indexPath.row]
        cell.cellVM = cellVM
            return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let _ = cell as? ProductTVCell else { return }
        if tableView.isLast(for: indexPath) {
            productsSearchVM?.loadNextPage()
        }
    }

}

//MARK: - SearchController Delegate
extension ProductsSearchVC: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        GCD.onMain { [weak self] in
            self?.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension ProductsSearchVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        productsSearchVM?.cancelSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()

        guard let keyword = searchBar.text, keyword.notEmpty()  else {
            loadingLbl.isHidden = false

            //Requesting here new keyword
            loadingLbl.text = Str.emptySearchTxtMsg
            return
        }

        ///Start search
        loadingLbl.text = Str.searchingMsg
        productsSearchVM?.searchForProducts(keyword: keyword)
    }
}

// MARK: - Interactions Functions
private extension ProductsSearchVC {
    /// configure completions from VM
    func configureCompletions() {
        productsSearchVM?.reload = { [weak self] in
            self?.reloadData()
        }
        
        productsSearchVM?.loading = { isLoading in
            if isLoading {
                GCD.onMain { [weak self] in
                    self?.loadingLbl.isHidden = false
                }
            } else {
                GCD.onMain { [weak self] in
                    self?.loadingLbl.isHidden = true
                }
            }
        }
    }
}
