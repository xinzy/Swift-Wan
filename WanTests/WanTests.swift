//
//  WanTests.swift
//  WanTests
//
//  Created by Yang on 2020/4/20.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import XCTest
@testable import Wan

class WanTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testDate() {
        let date = Date()
        print(date.timeIntervalSince1970)
    }
    
    func testStringReplace() {
        let string = "12345667"
        let other = string.replacingOccurrences(of: "123", with: "abc")
        print(other)
    }
    
    func testStringWidth() {
        let string = "测试bug"
        print(string.width(sizeOfSystem: 14))
    }
}
