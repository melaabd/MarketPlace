//
//  MocksServices.swift
//  MarketPlaceTests
//
//  Created by melaabd on 3/7/22.
//

import Foundation

class MocksServices: NetworkService {
    
    func searchFor(keyword: String, page: Int, completion: @escaping (SearchResult?, String?) -> Void) -> URLSessionDataTask? {
        guard keyword != "" else {
            completion(nil, "test faileur")
            return nil
        }
        
        if let path = Bundle.main.path(forResource: "ProductsSearshResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let productsResponse = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(productsResponse, nil)
            } catch {
                completion(nil, "Decoding Error")
            }
        }
        return nil
    }
    
    
}
