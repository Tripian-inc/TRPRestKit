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
    
    
    
    
    func testUserLogin() {
        let nameSpace = "TRPUserLogin"
        
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().login(userName: "necati@tripian.com", password: "123456") { (result, error) in
            
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
            guard let loginInfo = result as? TRPLoginInfoModel  else {
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
            guard let userInfo = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                expectation.fulfill()
                return
            }
            print("UserInfo \(userInfo)")
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
            guard let trips = result as? [TRPUserTripInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPUserTripInfoModel")
                expectation.fulfill()
                return
            }
            print("****** Trips \(trips.count)")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
