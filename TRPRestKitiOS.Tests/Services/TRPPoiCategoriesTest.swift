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
        let urlCreater = BaseUrlCreater(baseUrl: "6ezq4jb2mk.execute-api.eu-west-1.amazonaws.com", basePath: "api")
        TRPClient.start(baseUrl: urlCreater, apiKey: "")
        TRPClient.monitor(data: true, url: true)
    }
    
    /**
     * Test Place Of Interest Categories with no parameter given.
     */
    func testPoiCategories() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().poiCategory { (result, error, _) in
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
  
}
