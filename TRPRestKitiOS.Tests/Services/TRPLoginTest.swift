//
//  TRPLoginTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Rozeri Dağtekin on 10/30/19.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// # TRPCompanionTest that tests login functions operated by Rest - Kit.

import XCTest
@testable import TRPRestKit
@testable import TRPFoundationKit

class TRPLoginTest: XCTestCase {
    
    // MARK: Variables
    private let apiKey: String = "oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn"
    
    // MARK: Set Up
    override func setUp() {
        super.setUp()
        TRPApiKey.setApiKey(apiKey)
        TRPClient.start()
    }
    
    // MARK: - Test Functions
    
    /**
     * Tests login operation.
     */
    func testLogin() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().login(email: TestUtilConstants.MockUserConstants.Email, password: TestUtilConstants.MockUserConstants.Password) { (result, error) in
            if error != nil {
                let errorMsg: String = "\(nameSpace) \(error?.localizedDescription ?? "")"
                XCTFail(errorMsg)
                expectation.fulfill()
                fatalError(errorMsg)
            }
            guard result != nil else {
                expectation.fulfill()
                fatalError("result comes nil")
            }
            
            guard let result = result as? TRPLoginInfoModel else { return }
            
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.accessToken)
            XCTAssertNotNil(result.tokenType)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
