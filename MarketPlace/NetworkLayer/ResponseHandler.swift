//
//  NetworkResponse.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import Foundation

/// Defines network response status and provides error strings for network request error
enum NetworkError: Error {
    case invalidURL
    case authenticationError
    case badRequest
    case failed
    case noData
    case unableToDecode
    case noInternet
    
    var errorMsg:String? {
        switch self {
        case .invalidURL:
            return "invalid URL"
        case .authenticationError:
            return "Authentication Error"
        case .badRequest:
            return "Bad Request"
        case .failed:
            return "Network request Failed"
        case .noData:
            return "No Data Found"
        case .unableToDecode:
            return "Decoding Error"
        case .noInternet:
            return "No Internet Connectivity."
        }
    }
}

// MARK: - URLSession response handlers
extension URLSession {
    /// Checks URLResponse statusCode and returns a *NetworkResponse* case depending upon status
    /// - Parameter urlResponse: URLResponse received back from URLTask
    func parseHTTPResponse(_ urlResponse:HTTPURLResponse) -> NetworkError? {
        switch urlResponse.statusCode {
        case 200...299:
            return nil
        case 401...500:
            return .authenticationError
        case 501...600:
            return .badRequest
        default:
            return .failed
        }
    }
}

