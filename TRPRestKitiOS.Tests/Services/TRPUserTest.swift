//
//  TRPUserTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 11.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
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
        
        TRPRestKit().login(email: "necatievren@gmail.com", password: "123456") { (result, error) in
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
            
            XCTAssertNotNil(loginInfo.tokenType)
            XCTAssertNotEqual(loginInfo.accessToken.count, 0)
            XCTAssertTrue(TRPUserPersistent.didUserLoging())
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
            XCTAssertNotNil(userInfo.email)
            XCTAssertNotNil(userInfo.firstName)
            XCTAssertNotNil(userInfo.paymentStatus)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUserTrip() {
        let nameSpace = "TRPUserTrips"
        
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().userTrips { (result, error, _) in
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
            
            guard let firstTrip = trips.first else {
                return
            }
            
            XCTAssertNotNil(firstTrip.depatureTime)
            XCTAssertNotNil(firstTrip.arrivalTime)
            XCTAssertNotNil(firstTrip.city)
            XCTAssertNotNil(firstTrip.id)
            XCTAssertNotEqual(firstTrip.id, 0)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
 
    /*func testUserLogout() {
        XCTAssertTrue(TRPUserPersistent.didUserLoging())
        TRPRestKit().logout()
        XCTAssertFalse(TRPUserPersistent.didUserLoging())
    }*/
}
