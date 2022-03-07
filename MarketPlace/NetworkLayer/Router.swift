//
//  Router.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import Foundation

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]
typealias Component = [String: String]


protocol Router {
    var baseURL: String {get}
    var parameter: Parameters? { get }
    var components: Component? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var path: String { get }
    func getURLRequest() throws -> URLRequest
}


extension Router {
    // a default extension that creates the full URL
    var url: String {
        return baseURL + path
    }
    
    /// build URL
    /// - Returns: `URL`
    func asURL() throws -> URL {
        guard var urlComps = URLComponents(string: url) else { throw NetworkError.invalidURL }
        if let components = components {
            var queryItems:[URLQueryItem] = []
            for (key, value) in components {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            urlComps.queryItems = queryItems
        }
        guard let url = urlComps.url else { throw NetworkError.invalidURL }
        return url
    }
    
    /// add components for url request
    /// - Returns: `URLRequest`
    func getURLRequest() throws -> URLRequest {
        let url = try asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = parameter?.percentEncoded()
        urlRequest.httpMethod = method.rawValue
        guard let headers = headers else {return urlRequest }
        for (key, value) in headers {
            urlRequest.addValue(key, forHTTPHeaderField: value)
        }
        return urlRequest
    }
}
