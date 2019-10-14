//
//  TRPPlacesTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 11.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
import TRPRestKit
import TRPFoundationKit

class TRPPlacesTest: XCTestCase {
    
    
    private let cityId = 112
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    
    func testFethPlaceWithCityId() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().poi(withCityId: cityId) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            print(" ")
            print("***")
            print("PoiId - :\(firstPlace?.id)")
            print("***")
            print(" ")
            XCTAssertNotNil(firstPlace)
            
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFethPlacesWithIds() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().poi(withId: 58740) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            
            XCTAssertNotEqual(places.count, 0)
            guard let place = places.first else {
                XCTFail("\(nameSpace) Place is empty")
                return
            }
            
            XCTAssertEqual(place.id!, 58740)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    
    func testFethPlacesWithLocation() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        let cityLat = 41
        let cityLon = 29
        TRPRestKit().poi(withLocation: TRPLocation(lat: Double(cityLat), lon: Double(cityLon))) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            XCTAssertNotEqual(places.count, 0)
            XCTAssertNotNil(places.first)
            
            let firstPlace = places.first!
            XCTAssertNotNil(firstPlace.coordinate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFethPlacesWithLocationDistance() {
        let nameSpace = "TRPRestKit().city(withPlacesId:)"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().poi(withLocation: TRPLocation(lat: 41, lon: 29), distance: 10) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            if places.count < 1 {
                XCTFail("\(nameSpace) no exist data in array")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    
    func testFethPlacesWithLocationWithTypeId() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        let poiCategoryId = 3
        
        TRPRestKit().poi(withLocation: TRPLocation(lat: 41, lon: 29), categoryId: poiCategoryId) { (result, error, _) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            XCTAssertNotEqual(places.count, 0)
            XCTAssertNotNil(places.first)
            
            let firstPlace = places.first!
            XCTAssertNotNil(firstPlace.coordinate)
            XCTAssertNotEqual(firstPlace.category.count, 0)
            let mType = firstPlace.category.filter { (restType) -> Bool in
                if restType.id == poiCategoryId {
                    return true
                }
                return false
            }
            XCTAssertNotEqual(mType.count,0)
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 10.0)
    }
}

