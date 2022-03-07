//
//  ProductsSearchVMTests.swift
//  MarketPlaceTests
//
//  Created by melaabd on 3/7/22.
//

import XCTest
@testable import MarketPlace

class ProductsSearchVMTests: XCTestCase {
    
    var productsSearchVM: ProductsSearchVM!
    
    override func setUp() {
        super.setUp()
        
        productsSearchVM = ProductsSearchVM()
    }
    
    func test_fetching_data_fail() {
        
        productsSearchVM.searchForProducts(keyword: "")
        
        XCTAssertNil(productsSearchVM.searchTask) // double check for Test Scheme
        XCTAssertEqual(productsSearchVM.currentPage, 1)
        XCTAssertEqual(productsSearchVM.products.count, 0)
        XCTAssertEqual(productsSearchVM.productsVMs.count, 0)
    }

    func test_fetching_data_success() {
        productsSearchVM.searchForProducts(keyword: "something")
        XCTAssertEqual(productsSearchVM.currentSearch, "something")
        XCTAssertEqual(productsSearchVM.products.count, 4)
        XCTAssertEqual(productsSearchVM.productsVMs.count, 4)
    }
    
    func test_search_history() {
        productsSearchVM.searchForProducts(keyword:"Apple")
        productsSearchVM.searchForProducts(keyword:"Ap")
        
        XCTAssertEqual(productsSearchVM.searchHistory.count, 2)
        productsSearchVM.filterHistory(txt: "ap")
        XCTAssertEqual(productsSearchVM.filteredSearchHistory.count, 2)
        
        productsSearchVM.filterHistory(txt: "apple")
        XCTAssertEqual(productsSearchVM.filteredSearchHistory.count, 1)
        
        productsSearchVM.removeSearchHistoryItem(item: "Apple", idx: 0)
        XCTAssertEqual(productsSearchVM.searchHistory.count, 1)
    }
    
    func test_cancel_search_functionality() {
        productsSearchVM.searchForProducts(keyword: "something")
        XCTAssertEqual(productsSearchVM.currentSearch, "something")
        XCTAssertEqual(productsSearchVM.products.count, 4)
        XCTAssertEqual(productsSearchVM.productsVMs.count, 4)
        
        productsSearchVM.cancelSearch()
        XCTAssertEqual(productsSearchVM.products.count, 0)
        XCTAssertEqual(productsSearchVM.productsVMs.count, 0)
    }
    
    override func tearDown() {
        super.tearDown()
        
        productsSearchVM = nil
    }
}
