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
import TRPFoundationKit

class AcTRPLoginTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPRestKit().logout()
        
        changeServer(enviroment: .test)
        TRPClient.monitor(data: true, url: true)
    }
    
    override func tearDown() {
        TRPRestKit().logout()
    }
    
    private func resultController(result: Any?, error: Error?, testName: String, expectation: XCTestExpectation) {
        XCTAssertNil(error, "\(testName): \(error!.localizedDescription)")
        XCTAssertNotNil(result, "Result is nil: \(testName)")
        guard let result = result as? TRPLoginInfoModel else {
            expectation.fulfill()
            return
        }
        XCTAssertNotNil(result)
        XCTAssertNotNil(result.accessToken)
        XCTAssertNotNil(result.tokenType)
        expectation.fulfill()
    }
    
    // Login with UserName
    func testLoginWithUserNameOnTest() {
        changeServer(enviroment: .test)
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().login(withUserName: TestUtilConstants.MockUserConstants.TestUserName) { (result, error) in
            self.resultController(result: result, error: error, testName: nameSpace, expectation: expectation)
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUserLoginOnProduct() {
        changeServer(enviroment: .production)
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().login(withUserName: TestUtilConstants.MockUserConstants.TestUserName) { (result, error) in
            self.resultController(result: result, error: error, testName: nameSpace, expectation: expectation)
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUserLoginOnSandBox() {
        changeServer(enviroment: .sandbox)
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().login(withUserName: TestUtilConstants.MockUserConstants.TestUserName) { (result, error) in
            self.resultController(result: result, error: error, testName: nameSpace, expectation: expectation)
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // Login with tripHash
    
    // Login with Parameters/ Email
    func testUserLoginWithAirMiles() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPClient.start(baseUrl: TestUtilConstants.Server.airMiles.url, apiKey: TestUtilConstants.ApiKeys.AirMiles)
        
        let params = ["email": TestUtilConstants.MockUserConstants.Email,
                      "password": TestUtilConstants.MockUserConstants.Password]
        
        TRPRestKit().login(with: params) { (result, error) in
            self.resultController(result: result, error: error, testName: nameSpace, expectation: expectation)
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
