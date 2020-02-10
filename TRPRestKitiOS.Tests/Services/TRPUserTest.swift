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
        UserMockSession.shared.setServer()
        UserMockSession.shared.doLogin()
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
                XCTAssertNotNil(userInfo.paymentStatus)
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
                XCTAssertNotNil(userInfo.paymentStatus)
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
            
            guard let infoData = userInfo.info else {
                XCTFail("\(nameSpace) Info model is nil")
                expectation.fulfill()
                return
            }
            
            var resultArray = [Int]()
            for item in infoData {
                if item.key == "answers" {
                    resultArray = item.value.toIntArray()
                }
            }
        
            if TestUtilConstants.targetServer == .airMiles {
                XCTAssertNotNil(userInfo.firstName)
                XCTAssertNotNil(userInfo.paymentStatus)
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
            XCTAssertNotNil(firstTrip.depatureTime)
            XCTAssertNotNil(firstTrip.arrivalTime)
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
            XCTAssertNotNil(firstTrip.depatureTime)
            XCTAssertNotNil(firstTrip.arrivalTime)
            XCTAssertNotNil(firstTrip.city)
            XCTAssertNotNil(firstTrip.id)
            XCTAssertNotEqual(firstTrip.id, 0)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: User Favorites Tests
    
    /**
     * Tests Get User Favorites with no parameter given.
     */
    func testGetUserFavorites() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().getUserFavorite(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId) {[weak self](result, error) in
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
            guard let favs = result as? [TRPFavoritesInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPFavoritesInfoModel")
                expectation.fulfill()
                return
            }
            
            guard let firstFav = favs.first else {
                return
            }
            
            XCTAssertGreaterThan(favs.count , 0)
            XCTAssertGreaterThan(firstFav.poiId , 0)
            XCTAssertEqual(firstFav.cityId , TestUtilConstants.MockCityConstants.IstanbulCityId)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Tests Add User Favorite operation,
     * by first getting the random place of interest of the foretold city,
     * then, adds place of interest with cityId parameter
     * then, gets the user's favorite places
     * and checks whether place is added to the favorites of the current user.
     */
    func testAddUserFavorite() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().poi(withCityId: TestUtilConstants.MockCityConstants.IstanbulCityId) {[weak self] (result, error, _) in
            guard self != nil else {return}
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPPoiInfoModel")
                return
            }
            
            guard let firstPlace = places.first else { return }
            
            guard let firstPlaceId = firstPlace.id else { return }
            
            TRPRestKit().addUserFavorite(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId, poiId: firstPlaceId) {[weak self] (result, error) in
                guard self != nil else {return}
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    return
                }
                guard let result = result else {
                    XCTFail("\(nameSpace) Result is nil")
                    return
                }
                guard let fav = result as? TRPFavoritesInfoModel  else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPFavoritesInfoModel")
                    return
                }
                
                XCTAssertEqual(fav.poiId, firstPlaceId)
                XCTAssertEqual(fav.cityId, TestUtilConstants.MockCityConstants.IstanbulCityId)
                
                TRPRestKit().getUserFavorite(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId) {[weak self](result, error) in
                    guard self != nil else {return}
                    
                    if let error = error {
                        XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                        return
                    }
                    guard let result = result else {
                        XCTFail("\(nameSpace) Result is nil")
                        return
                    }
                    guard let favs = result as? [TRPFavoritesInfoModel]  else {
                        XCTFail("\(nameSpace) Json model coundn't converted to  TRPFavoritesInfoModel")
                        return
                    }
                    
                    let favOfFirstPlace = favs.filter { $0.poiId == firstPlaceId }.first
                    XCTAssertEqual(favOfFirstPlace?.poiId, firstPlaceId)
                    XCTAssertEqual(favOfFirstPlace?.cityId, TestUtilConstants.MockCityConstants.IstanbulCityId)
                    expectation.fulfill()
                }
            }
        }
        //Waits for 3 request calls.
        wait(for: [expectation], timeout: 30.0)
    }
    
    /**
     * Tests Remove User Favorite operation,
     * by first getting the random place of interest of the foretold city,
     * then, removes place of interest with cityId and given random favorite place id parameter
     * then, gets the user's favorite places
     * and checks whether place is removed from the favorites of the current user.
     */
    func testRemoveUserFavorite() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().getUserFavorite(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId) {[weak self] (result, error) in
            guard self != nil else {return}
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            
            guard let favs = result as? [TRPFavoritesInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPFavoritesInfoModel")
                return
            }
            
            guard let firstFav = favs.first else {
                return
            }
            
            TRPRestKit().deleteUserFavorite(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId, poiId: firstFav.poiId) {[weak self] (result, error) in
                guard self != nil else {return}
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    return
                }
                guard let result = result else {
                    XCTFail("\(nameSpace) Result is nil")
                    return
                }
                guard result is TRPParentJsonModel  else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPParentJsonModel")
                    return
                }
                
                TRPRestKit().getUserFavorite(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId) {[weak self](result, error) in
                    guard self != nil else {return}
                    
                    if let error = error {
                        XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                        return
                    }
                    guard let result = result else {
                        XCTFail("\(nameSpace) Result is nil")
                        return
                    }
                    guard let favs = result as? [TRPFavoritesInfoModel]  else {
                        XCTFail("\(nameSpace) Json model coundn't converted to  TRPFavoritesInfoModel")
                        return
                    }
                    
                    let favOfFirstPlace = favs.filter { $0.poiId == firstFav.poiId}.first
                    
                    XCTAssertNil(favOfFirstPlace)
                    expectation.fulfill()
                }
            }
        }
        //Waits for 3 request calls.
        wait(for: [expectation], timeout: 30.0)
    }
    
}
