//
//  TRPUserFavorite.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 4.03.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
import XCTest
@testable import TRPRestKit

class TRPUserFavorite: XCTestCase {
    
    override func setUp() {
        UserMockSession.shared.setServer()
        UserMockSession.shared.doLogin()
    }
    
    //Get empty user favorites with City id
    /**
     * Tests Get User Favorites with no parameter given.
     */
    func testGetUserFavorites() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().getUserFavorite(cityId: 99) {[weak self](result, error) in
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
            
            XCTAssertEqual(favs.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    //Add user favorites for Istanbul
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
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                expectation.fulfill()
                return
            }
            guard let places = result as? [TRPPoiInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPPoiInfoModel")
                expectation.fulfill()
                return
            }
            
            guard let firstPlace = places.first else { return }
            
            TRPRestKit().addUserFavorite(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId, poiId: firstPlace.id) {[weak self] (result, error) in
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
                guard let fav = result as? [TRPFavoritesInfoModel]  else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPFavoritesInfoModel")
                    expectation.fulfill()
                    return
                }
                
                let isExist = fav.contains{$0.poiId == firstPlace.id}
                
                XCTAssert(isExist)
                //XCTAssertEqual(fav.cityId, TestUtilConstants.MockCityConstants.IstanbulCityId)
                
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
                    
                    let favOfFirstPlace = favs.filter { $0.poiId == firstPlace.id }.first
                    XCTAssertEqual(favOfFirstPlace?.poiId, firstPlace.id)
                    XCTAssertEqual(favOfFirstPlace?.cityId, TestUtilConstants.MockCityConstants.IstanbulCityId)
                    expectation.fulfill()
                }
            }
        }
        //Waits for 3 request calls.
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testAddFavoriteSamePoint() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        let poiId = "520705"
        TRPRestKit().addUserFavorite(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId, poiId: poiId) { (_, error) in
            if  error != nil {
                expectation.fulfill()
                return
            }
            TRPRestKit().addUserFavorite(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId, poiId: poiId) { (mResult, merror) in
                XCTAssertNotNil(merror)
                if mResult is [TRPFavoritesInfoModel] {
                    XCTFail()
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    //Get User Favorites for Istanbul
    func testGetIstanbul() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
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
            
            XCTAssertGreaterThan(favs.count, 0)
            XCTAssertEqual(favs.first!.cityId, TestUtilConstants.MockCityConstants.IstanbulCityId)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
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
                expectation.fulfill()
                return
            }
            
            TRPRestKit().deleteUserFavorite(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId, favoriteId: firstFav.id) {[weak self] (result, error) in
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
                guard result is TRPParentJsonModel  else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPParentJsonModel")
                    expectation.fulfill()
                    return
                }
                
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
