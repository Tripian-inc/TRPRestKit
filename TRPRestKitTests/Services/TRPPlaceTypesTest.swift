//
//  TRPPlaceTypesTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 10.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
@testable import TRPFoundationKit
class TRPPlaceTypesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    
    func testFethAllPlaceTypes() {
        let nameSpace = "TRPPlaceTypes"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().placeTypes { (result, error, pagination) in
        
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let types = result as? [TRPPlaceTypeInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPPlaceTypeInfoModel")
                return
            }
            if types.count < 1 {
                XCTFail("\(nameSpace) no exist data in array")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFethIstanbul() {
        let nameSpace = "TRPPlaceTypes"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().placeTypes(withId: 1) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPPlaceTypeInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPPlaceTypeInfoModel")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
