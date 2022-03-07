//
//  HTTPMethod.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//


import Foundation

struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    /// `GET` method.
    static let get = HTTPMethod(rawValue: "GET")

    let rawValue: String

    init(rawValue: String) {
        self.rawValue = rawValue
    }
}
