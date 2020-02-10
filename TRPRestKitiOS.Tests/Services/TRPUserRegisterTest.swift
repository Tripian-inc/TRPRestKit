//
//  TRPUserRegisterTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 18.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class TRPUserRegisterTest: XCTestCase {

    public static var userName: String = "mobile_unit_test_user_"
    
    override class func setUp() {
        TRPUserRegisterTest.userName += "\(Int.random(in: (100...500)))"
        TRPClient.monitor(data: true, url: true)
    }
    
    private func loginServeci(expectation: XCTestExpectation, name: String) {
        TRPRestKit().register(userName: TRPUserRegisterTest.userName) { (result, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            guard let model = result as? TRPRegisterUserInfo else {
                XCTFail("TRPUserInfoModel couldn't be converted for \(name)")
                expectation.fulfill()
                return
            }
            XCTAssertEqual(model.userName, TRPUserRegisterTest.userName, "New user name not equal")
            expectation.fulfill()
        }
    }
    
    func testUserRegisterForTestServer() {
        changeServer(enviroment: .test)
        let functionName = "\(#function)"
        let expectation = XCTestExpectation(description: "\(functionName) expectation")
        loginServeci(expectation: expectation, name: "\(functionName)")
        wait(for: [expectation], timeout: 4)
    }
    
    func testUserSameAccount() {
        changeServer(enviroment: .test)
        let expectation = XCTestExpectation(description: "\(#function) expectation")
        TRPRestKit().register(userName: TRPUserRegisterTest.userName) { (_, error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
    }
    
    func testUserRegisterForProductServer() {
        changeServer(enviroment: .production)
        let functionName = "\(#function)"
        let expectation = XCTestExpectation(description: "\(functionName) expectation")
        loginServeci(expectation: expectation, name: "\(functionName)")
        wait(for: [expectation], timeout: 4)
    }
    
    func testUserRegisterForSandBoxServer() {
        changeServer(enviroment: .sandbox)
        let functionName = "\(#function)"
        let expectation = XCTestExpectation(description: "\(functionName) expectation")
        loginServeci(expectation: expectation, name: "\(functionName)")
        wait(for: [expectation], timeout: 4)
    }
    
    func testUserRegisterForAirmilesServerMustBeFail() {
        TRPClient.start(baseUrl: TestUtilConstants.Server.airMiles.url, apiKey: TestUtilConstants.Server.airMiles.apiKey)
        let functionName = "\(#function)"
        let expectation = XCTestExpectation(description: "\(functionName) expectation")
        TRPRestKit().register(userName: TRPUserRegisterTest.userName) { (_, error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
    }

}
