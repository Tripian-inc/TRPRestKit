//
//  TRPUserTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 11.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
import TRPRestKit

class TRPUserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    
    func testUserRegister() {
        let nameSpace = "TRPUserRegister"
        let name = "Evren"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().register(firstName: name, lastName: "Yasar", email: "necati@tripian.com", password: "123456") { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let registerResult = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                return
            }
            
            XCTAssertEqual(registerResult.firstName, name,"User Name not equal")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testUserLogin() {
        let nameSpace = "TRPUserLogin"
        
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().login(email: "necati@tripian.com", password: "123456") { (result, error) in
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                expectation.fulfill()
                return
            }
            guard let _ = result as? TRPLoginInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testUserInfo() {
        let nameSpace = "TRPUserInfo"
        
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().userInfo { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                expectation.fulfill()
                return
            }
            guard let _ = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
        }
       
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testUserTrip() {
        let nameSpace = "TRPUserTrips"
        
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().userTrips { (result, error, paging) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                expectation.fulfill()
                return
            }
            guard let _ = result as? [TRPUserTripInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPUserTripInfoModel")
                expectation.fulfill()
                return
            }
            
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
