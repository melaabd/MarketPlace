//
//  ProductsSearchPage.swift
//  MarketPlaceUITests
//
//  Created by melaabd on 3/6/22.
//

import XCTest

class ProductsSearchPage {
    
    var app: XCUIApplication!
    var searchNavigationBar: XCUIElement!
    
    init(app: XCUIApplication) {
        self.app = app
        searchNavigationBar = app.navigationBars[AccessibilityIds.productsSearchNavigationBarId]
    }
    
    var searchBar: XCUIElement {
        return searchNavigationBar.staticTexts[AccessibilityIds.productsSearchSearchBarId]
    }
    
    var loadingLbl: XCUIElement {
        return app.staticTexts[AccessibilityIds.productsSearchLoadingLblId]
    }
}
