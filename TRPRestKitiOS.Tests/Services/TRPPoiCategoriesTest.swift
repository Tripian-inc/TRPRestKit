//
//  TRPPoiCategoriesTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 14.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// # TRPPoiCategoriesTest that tests poi categories functions operated by Rest - Kit.

import XCTest
@testable import TRPRestKit

class TRPPoiCategoriesTest: XCTestCase {
    
    // MARK: Set Up
    override func setUp() {
        super.setUp()
    }
    
    /**
     * Test Place Of Interest Categories with no parameter given.
     */
    func testPoiCategories() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().poiCategories { (result, error, _) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
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
    
    /**
     * Test Place Of Interest Categories with given poiCategoryId.
     */
    func testPoiCategoriesWithId() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expect")
        
        TRPRestKit().poiCategory(withId: TestUtilConstants.MockPoiCategoryConstants.PoiCategoryId) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let data = result as? TRPCategoryInfoModel  else {
                XCTFail("\(nameSpace) Json model couldn't converted to  TRPCategoryInfoModel")
                return
            }
            XCTAssertEqual(data.id, TestUtilConstants.MockPoiCategoryConstants.PoiCategoryId)
            XCTAssertNotEqual(data.name.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
}
