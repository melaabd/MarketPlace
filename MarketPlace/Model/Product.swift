//
//  Product.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import Foundation

// MARK: - Products
struct SearchResult: Codable {
    var products: [Product]
    var currentPage, pageSize, totalResults, pageCount: Int
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let name: String
    let reviewInformation: ReviewInformation
    let usPs: [String]
    let availabilityState: Int
    let salesPriceIncVat: Double
    let imageUrl: URL
    let nextDayDelivery: Bool
    let coolbluesChoiceInformationTitle: String?
    let listPriceIncVat: Int?
    let listPriceExVat: Double?

    enum CodingKeys: String, CodingKey {
        case id = "productId"
        case name = "productName"
        case imageUrl = "productImage"
        case usPs = "USPs"
        case reviewInformation, availabilityState, salesPriceIncVat,
             coolbluesChoiceInformationTitle, nextDayDelivery,
             listPriceIncVat, listPriceExVat
    }
}

// MARK: - ReviewInformation
struct ReviewInformation: Codable {
    let reviews: [String]
    let summary: ReviewSummary

    enum CodingKeys: String, CodingKey {
        case summary = "reviewSummary"
        case reviews
    }
}

// MARK: - ReviewSummary
struct ReviewSummary: Codable {
    let average: Double
    let count: Int

    enum CodingKeys: String, CodingKey {
        case average = "reviewAverage"
        case count = "reviewCount"
    }
}
