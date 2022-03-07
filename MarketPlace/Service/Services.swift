//
//  Services.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import Foundation

class Services: NetworkService {
    
    var manager:APIManager {
        return APIManager()
    }
        
    /// - Parameters:
    ///   - keyword: `String`
    ///   - page: `Int`
    ///   - completion: `(SearchResult?, String?)`
    /// - Returns: `URLSessionDataTask`
    func searchFor(keyword:String, page:Int, completion: @escaping (SearchResult?, String?) -> Void) -> URLSessionDataTask? {
        let components: Component = ["query": keyword, "page": "\(page)"]
        let endPoint = EndPoint.searchInProducts(components: components)
        var searchInProductsURLRequest:URLRequest!
        do {
            searchInProductsURLRequest = try endPoint.getURLRequest()
        } catch {
            if let error = error as? NetworkError {
                completion(nil, error.errorMsg)
            } else {
                completion(nil, error.localizedDescription)
            }
        }
        
        let task = manager.codableTask(with: searchInProductsURLRequest) { (result: Result<SearchResult, NetworkError>) in
            switch result {
            case .success(let products):
                completion(products, nil)
            case .failure(let error):
                completion(nil, error.errorMsg)
            }
        }
        task.resume()
        return task
    }
}
