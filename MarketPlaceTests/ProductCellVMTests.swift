//
//  MarketPlaceTests.swift
//  MarketPlaceTests
//
//  Created by melaabd on 3/6/22.
//

import XCTest
@testable import MarketPlace

class ProductCellVMTests: XCTestCase {

    var data:Data!
    
    override func setUp() {
        super.setUp()
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "ProductObjectInResponse", ofType: "json")
        data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
    }
    
    func test_data_parsing_in_model() {
        
        XCTAssertNoThrow(try! JSONDecoder().decode(Product.self, from: data))
        let product = try! JSONDecoder().decode(Product.self, from: data)
        XCTAssertNotNil(product.id)
        XCTAssertNotNil(product.name)
    }
    
    func test_productCellVM_computed_values() {
        
        let product = try! JSONDecoder().decode(Product.self, from: data)
        let productCellVM = ProductCellVM(product: product)
        
        XCTAssertEqual(productCellVM.imageUrl, URL(string: "https://image.coolblue.nl/300x750/products/818870"))
        XCTAssertEqual(productCellVM.review, "🌟 9.1 | 952 Reviews")
        XCTAssertEqual(productCellVM.USPs, "• 32 GB opslagcapaciteit\n• 4,7 inch Retina HD scherm\n• iOS 11")
        XCTAssertEqual(productCellVM.price, "369.00")
        
    }
    
    override  func tearDown() {
        super.tearDown()
        
        data = nil
    }
}
