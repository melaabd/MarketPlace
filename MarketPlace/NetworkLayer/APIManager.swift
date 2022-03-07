//
//  APIManager.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import Foundation

struct APIManager {
    
    var session: URLSession!
    let timeOut = 60.0
        
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeOut
        configuration.timeoutIntervalForResource = timeOut
        session = URLSession(configuration: configuration)
    }
    
    /// base codableTask with custom url and geniric model
    /// - Returns: URLSessionDataTask
    func codableTask<T: Codable>(with urlRequest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask {
        session.dataTask(with: urlRequest) { data, response, error in
            
            if let _ = error {
                completion(.failure(.noInternet))
                return
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse else {
                completion(.failure(.failed))
                return
            }
            
            if let networkError = session.parseHTTPResponse(httpURLResponse) {
                completion(.failure(networkError))
            } else {
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            }
            
        }
    }
}
