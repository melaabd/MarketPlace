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
    private var shouldShowhHistory:Bool = false
    
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
        tableView.register(SearchHistoryTVCell.self, forCellReuseIdentifier: SearchHistoryTVCell.identifier)
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
        let noOfRows = shouldShowhHistory ? productsSearchVM?.filteredSearchHistory.count ?? 0 : productsSearchVM?.productsVMs.count ?? 0
        (noOfRows == 0) ? tableView.setEmptyView("No Results") : tableView.setEmptyView()
        return noOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if shouldShowhHistory {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTVCell.identifier, for: indexPath) as? SearchHistoryTVCell ?? SearchHistoryTVCell()
            
            guard let itemTitle = productsSearchVM?.filteredSearchHistory[indexPath.item] else { return cell }
            cell.cellVM = SearchHistoryCellVM(title: itemTitle)
            cell.removeItemCompletion = { [weak self] in
                guard let self = self, let title = cell.cellVM?.title else { return }
                self.productsSearchVM?.removeSearchHistoryItem(item: title, idx: indexPath.row)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTVCell.identifier, for: indexPath) as? ProductTVCell ?? ProductTVCell()
            let cellVM = productsSearchVM?.productsVMs[indexPath.row]
            cell.cellVM = cellVM
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let _ = cell as? ProductTVCell else { return }
        if tableView.isLast(for: indexPath) {
            productsSearchVM?.loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard shouldShowhHistory, let itemTxt = productsSearchVM?.filteredSearchHistory[indexPath.item] else { return }
        searchController.searchBar.text = itemTxt
        searchBarSearchButtonClicked(searchController.searchBar)
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
        shouldShowhHistory = false
        reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension ProductsSearchVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        productsSearchVM?.cancelSearch()
        shouldShowhHistory = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        shouldShowhHistory = false
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let txt = searchBar.text, txt.notEmpty()  else {
            shouldShowhHistory = false
            reloadData()
            return
        }
        shouldShowhHistory = true
        productsSearchVM?.filterHistory(txt: txt)
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
