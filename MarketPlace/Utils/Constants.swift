//
//  Constants.swift
//  MarketPlace
//
//  Created by melaabd on 3/6/22.
//

import Foundation


/// Constant API's Keys in the app
struct Keys {
    /// base url for APIs
    static let baseURL = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/"
}

/// Constant ids for ui components
struct AccessibilityIds {
    static let productsSearchSearchBarId = "productsSearchSearchBarId",
               productsSearchNavigationBarId = "productsSearchNavigationBarId",
               productsSearchLoadingLblId = "productsSearchLoadingLblId";
}

/// Constant strings in the app
struct Str {
    static let searchVCTitle = "Market Search",
               searchBarPlaceholder = " what are you looking for?",
               emptySearchTxtMsg = "Please type keyword to search result.",
               searchingMsg = "Searching products...";
}
