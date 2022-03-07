//
//  ExString.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//


import Foundation

extension String {
    
    /// remove spaces from string
    /// - Returns: `String` after remove spaces
    func notEmpty() -> Bool {
        let txtWithoutSpaces = self.components(separatedBy: .whitespacesAndNewlines).joined()
        return !txtWithoutSpaces.isEmpty
    }
}
