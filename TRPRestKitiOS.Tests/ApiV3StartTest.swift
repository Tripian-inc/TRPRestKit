//
//  ApiV3StartTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 25.02.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class ApiV3StartTest: XCTestCase {

    override func setUp() {
        let urlCreater = BaseUrlCreater(baseUrl: "6ezq4jb2mk.execute-api.eu-west-1.amazonaws.com", basePath: "api")
        TRPClient.start(baseUrl: urlCreater, apiKey: "")
        TRPClient.monitor(data: true, url: true)
    }

    func testUserRegister() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
         
        TRPRestKit().register(email: "silV3_9@fakemailxyz.com", password: "123456aA", firstName: "Ali", lastName: "Veli", answers: [1,2,3,4]) { (result, error) in
            XCTAssertNil(error)
            
            if let result = result as? TRPUserInfoModel {
                print("SONUC \(result)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testLogin() {
        //silV3_9@fakemailxyz.com
        //123456aA
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().login(withEmail: "silV3_9@fakemailxyz.com", password: "123456aA") { (result, error) in
            XCTAssertNil(error)
            
            if let result = result as? TRPLoginInfoModel {
                print("SONUC \(result)")
            }
            expectation.fulfill()
        }
         wait(for: [expectation], timeout: 20.0)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
