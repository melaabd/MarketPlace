//
//  ProductsSearchVCTests.swift
//  ProductsSearchVCTests
//
//  Created by melaabd on 3/6/22.
//

import XCTest
@testable import MarketPlace

class ProductsSearchVCTests: XCTestCase {

    private var app: XCUIApplication!
    private var pageObject: ProductsSearchPage!
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        pageObject = ProductsSearchPage(app: app)
        continueAfterFailure = false
        app.launch()
        
    }
    
    func test_SearchBar_when_App_launch() {
        
        let searchBar = pageObject.searchBar
        XCTAssertEqual(searchBar.label, "")
    }
    
    func test_loading_label_when_App_launch() {
        
        XCTAssertFalse(pageObject.loadingLbl.exists)
    }
    
    override func tearDown() {
        super.tearDown()
        
        app = nil
        pageObject = nil
    }
}
