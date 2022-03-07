//
//  EndPointTests.swift
//  MarketPlaceTests
//
//  Created by melaabd on 3/7/22.
//

import XCTest
@testable import MarketPlace

class EndPointTests: XCTestCase {
    
    
    func test_endPoint_builder() {
        let page:Int = 1
        let searchKeyword:String = "Apple"
        let components: Component = ["query": searchKeyword, "page": "\(page)"]
        let searEndPoint = EndPoint.searchInProducts(components: components)
        let endPointUrlString = try! searEndPoint.asURL().absoluteString
        let staticUrlString1 = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/search?page=\(page)&query=\(searchKeyword)"
        let staticUrlString2 = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/search?query=\(searchKeyword)&page=\(page)"
        
        let isEqual = (endPointUrlString == staticUrlString1 ||  endPointUrlString == staticUrlString2 )
        
        
        
        XCTAssertNoThrow(try searEndPoint.asURL())
        XCTAssertTrue(isEqual)
        
    }

}
