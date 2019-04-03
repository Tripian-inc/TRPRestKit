//
//  EvrenTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 2.04.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
import TRPRestKit

class EvrenTest: XCTestCase {

    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }

    override func tearDown() {}

    func testCity() {
        TRPRestKit().city(with: 1) { (result, error) in
            
        }
    }
    
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
