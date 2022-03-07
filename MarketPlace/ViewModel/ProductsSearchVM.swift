//
//  ProductsSearchVM.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import Foundation


class ProductsSearchVM {
    
    /// show alert 
    weak var alertDelegate: AlertDelegate?
    
    /// loading status
    var loading: StatusCompletion?
    /// reload completion
    var reload: Completion?
    
    /// current running remote task
    var searchTask: URLSessionDataTask?
    
    /// current search keyword
    var currentSearch:String?
    
    /// last loaded page of result
    var currentPage:Int = 1
    
    /// number of result pages
    var pageCount:Int = 1
    
    /// loaded Products
    var products:[Product] = []
    
    /// products cell view models
    var productsVMs:[ProductCellVM] = []
    
    let service:NetworkService = NetworkServiceFactory.create()
    
    
    /// fetch data from server by passing keyword and page
    /// - Parameters:
    ///   - keyword: `String`
    ///   - page: `Int`
    func searchForProducts(keyword: String, page: Int = 1) {
        currentSearch = keyword
        currentPage = page
        loading?(true)
        searchTask = service.searchFor(keyword: keyword, page: page) { [weak self] searchResult, msg in
            guard let self = self else { return }
            self.loading?(false)
            if let errMsg = msg {
                self.alertDelegate?.alertWith(msg: errMsg)
            } else if let result = searchResult {
                self.handleProductsData(result: result)
            }
            
        }
    }
    
    /// load nex page of result
    func loadNextPage() {
        guard let keyword = currentSearch, pageCount > currentPage else { return }
        searchForProducts(keyword: keyword, page: currentPage + 1)
    }
    
    /// set data in cell view models by passing search result
    /// - Parameter result: `SearchResult`
    func handleProductsData(result: SearchResult) {
        currentPage = result.currentPage
        pageCount = result.pageCount
        if currentPage == 1 {
            products = result.products
            productsVMs = result.products.map{ ProductCellVM(product: $0) }
        } else {
            products.append(contentsOf: result.products)
            productsVMs.append(contentsOf: result.products.map{ ProductCellVM(product: $0) })
        }
        reload?()
    }
    
    /// cancel current search
    func cancelSearch() {
        loading?(false)
        searchTask?.cancel()
        products.removeAll()
        productsVMs.removeAll()
        currentSearch = nil
        reload?()
    }
    
}
