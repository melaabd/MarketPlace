//
//  ProductCellVM.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import Foundation

struct ProductCellVM {
    
    var product:Product
    
    var name: String {
        return product.name
    }
    
    var review: String {
        return "🌟 \(product.reviewInformation.summary.average) | \(product.reviewInformation.summary.count) Reviews"
    }
    
    var imageUrl: URL? {
        return product.imageUrl
    }
    
    var USPs: String {
        return "• " + product.usPs.joined(separator: "\n• ")
    }
    
    var price: String {
        return String(format: "%.2f", product.salesPriceIncVat)
    }
}
