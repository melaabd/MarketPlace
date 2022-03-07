//
//  EndPoint.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import Foundation

enum EndPoint: Router {
    
    case searchInProducts(components: Component)
    
    var baseURL: String {
        return Keys.baseURL
    }
    
    /// return endPoint's parameter `Parameters`
    var parameter: Parameters? {
        return nil
    }
    
    /// return endPoint's components `Component`
    var components: Component? {
        switch self {
        case .searchInProducts(let components):
            return components
        }
    }
    
    /// return endPoint's path `String`
    var path : String {
        switch self {
        case .searchInProducts:
            return "search"
        }
    }
    
    /// return endPoint's`HTTPMethod`
    var method: HTTPMethod {
        return .get
    }
    
    /// return router's `HTTPHeaders`
    var headers: HTTPHeaders? {
        return nil
    }
    
}
