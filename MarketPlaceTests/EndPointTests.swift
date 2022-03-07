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
        XCTAssertEqual(searEndPoint.url, "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/search")
        XCTAssertNoThrow(try searEndPoint.asURL())
        XCTAssertEqual(try searEndPoint.asURL(), URL(string: "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/search?page=\(page)&query=\(searchKeyword)"))
        
    }

}
