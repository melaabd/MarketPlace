//
//  NetworkService.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import Foundation


protocol NetworkService {
    
    func searchFor(keyword:String, page:Int, completion: @escaping (SearchResult?, String?) -> Void) -> URLSessionDataTask?
}

class NetworkServiceFactory {
    
    static func create() -> NetworkService {
        let environment = ProcessInfo.processInfo.environment["ENV"]
        if let env = environment, env == "TEST" {
            return MocksServices()
        } else {
            return Services()
        }
    }
}
