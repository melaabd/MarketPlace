//
//  GCDTest.swift
//  MarketPlaceTests
//
//  Created by melaabd on 3/8/22.
//

import XCTest
@testable import MarketPlace

class GCDTests: XCTestCase {
    
    func test_main_thread_short_cut() {
        GCD.onMain {
            XCTAssertTrue(Thread.current.isMainThread)
        }
    }
}
