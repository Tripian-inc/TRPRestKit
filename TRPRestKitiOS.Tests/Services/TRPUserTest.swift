//
//  TRPUserTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 11.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// # TRPUserTest tests user functions such as: login, getUserInfo operations by Rest - Kit.

import XCTest
import TRPRestKit

// swiftlint:disable all
class AeTRPUserTest: XCTestCase {
    
    // MARK: Set Up 
    override func setUp() {
        super.setUp()
        //UserMockSession.shared.setServer()
        //UserMockSession.shared.doLogin()
        let urlCreater = BaseUrlCreater(baseUrl: "6ezq4jb2mk.execute-api.eu-west-1.amazonaws.com", basePath: "api")
           TRPClient.start(baseUrl: urlCreater, apiKey: "")
           TRPClient.monitor(data: true, url: true)
    }
    
    // MARK: User Info Tests
    
    /**
     * Tests User Info with no parameter given.
     */
    func testUserInfo() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().userInfo { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                expectation.fulfill()
                return
            }
            guard let userInfo = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPUserInfoModel")
                expectation.fulfill()
                return
            }
            
            if TestUtilConstants.targetServer == .airMiles {
                XCTAssert(!userInfo.email.isEmpty)
                XCTAssertNotNil(userInfo.firstName)
                
            }else {
                XCTAssert(!userInfo.username.isEmpty)
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Tests Update User Info with with given firstName and lastName parameter.
     */
    func testUpdateUserInfoWithName() {
        let nameSpace = #function
        let randomFirstName = randomString(length: 7)
        let randomLastName = randomString(length: 7)
        
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().updateUserInfo(firstName: randomFirstName, lastName: randomLastName) {[weak self] (result, error) in
            
            guard self != nil else {return}
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                expectation.fulfill()
                return
            }
            
            guard let userInfo = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPUserInfoModel")
                expectation.fulfill()
                return
            }
            
            
            if TestUtilConstants.targetServer == .airMiles {
                XCTAssertNotNil(userInfo.firstName)
                XCTAssertEqual(userInfo.firstName, randomFirstName)
                XCTAssertEqual(userInfo.lastName, randomLastName)
            }else {
                XCTAssertNotNil(userInfo.email)
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Tests Update User Answers with given answers parameter.
     */
    func testUpdateUserInfoWithAnswers() {
        let nameSpace = #function
        let mockAnswers = [42, 43]
        
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().updateUserAnswer(answers: mockAnswers) { [weak self] (result, error) in
            guard self != nil else {return}
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                expectation.fulfill()
                return
            }
            
            guard let userInfo = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPUserInfoModel")
                expectation.fulfill()
                return
            }
    
            XCTAssertNotNil(userInfo.profile)
            let resultArray = userInfo.profile!.answers
        
            if TestUtilConstants.targetServer == .airMiles {
                XCTAssertNotNil(userInfo.firstName)
                
            }else {
                XCTAssertNotNil(userInfo.email)
            }
            XCTAssertEqual(resultArray, mockAnswers)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: User Trips Tests
    
    /**
     * Tests Get User Trips, with no given parameter and thus,
     * response should give all the trips of the user.
     */
    func testUserTrips() {
        //TODO: - USERTRİP E GÖRE YENİDEN AÇILACAK
        print("[debug]: \(TRPUserPersistent.didUserLoging())")
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().userTrips { (result, error, _) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
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
            
            XCTAssertGreaterThan(trips.count, 0)
            
            XCTAssertNotNil(firstTrip.city)
            XCTAssertNotNil(firstTrip.id)
            XCTAssertNotEqual(firstTrip.id, 0)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Tests Get User Trips, with given 20 limit parameter and thus,
     * response should give all the trips of the user, till today limited to 20 trips
     */
    func testUserTripsWith20Limit() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().userTrips(limit: 20) { (result, error, _) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
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
            
            XCTAssertGreaterThan(trips.count, 0)
            //XCTAssertNotNil(firstTrip.depatureTime)
            //XCTAssertNotNil(firstTrip.arrivalTime)
            XCTAssertNotNil(firstTrip.city)
            XCTAssertNotNil(firstTrip.id)
            XCTAssertNotEqual(firstTrip.id, 0)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: User Favorites Tests
    
   
    
   
    
   
    
}
