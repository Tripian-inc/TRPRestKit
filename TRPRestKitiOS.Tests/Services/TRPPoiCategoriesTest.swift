//
//  TRPPoiCategoriesTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 14.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class TRPPoiCategoriesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
        TRPClient.printData(true)
    }
    
    func testPoiCategories() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expect6677788899")
        
        TRPRestKit().poiCategories { (result, error, _) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let data = result as? [TRPCategoryInfoModel]  else {
                XCTFail("\(nameSpace) Json model couldn't converted to  TRPCategoryInfoModel")
                return
            }
            XCTAssertNotEqual(data.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testPoiCateforyWithId() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expect")
        let poiType = 3
        TRPRestKit().poiCategory(withId: poiType) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let data = result as? TRPCategoryInfoModel  else {
                XCTFail("\(nameSpace) Json model couldn't converted to  TRPCategoryInfoModel")
                return
            }
            XCTAssertEqual(data.id, poiType)
            XCTAssertNotEqual(data.name.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20)
    }
    
}
