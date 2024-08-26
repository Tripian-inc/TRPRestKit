//
//  TRPPoiTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 14.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// # TRPCitiesTest class which tests cities functions operated by Rest - Kit.

import XCTest
@testable import TRPRestKit
import TRPFoundationKit
// swiftlint:disable all
class TRPPoiTest: XCTestCase {
    
    // MARK: Variables
    private let cityId = TestUtilConstants.MockCityConstants.BogotaCityId
    private let placeId = "46636" //TestUtilConstants.MockPlaceConstants.PlaceId
    private let location = TestUtilConstants.MockCityConstants.Bogotalocation
    private let category = TestUtilConstants.MockPoiCategoryConstants.PoiCategoryId
    private let categoryIds = TestUtilConstants.MockPoiCategoryConstants.CategoryIds
    
    // MARK: Set Up
    override func setUp() {
        super.setUp()
        let urlCreater = BaseUrlCreater(baseUrl: "6ezq4jb2mk.execute-api.eu-west-1.amazonaws.com", basePath: "api")
        TRPClient.start(baseUrl: urlCreater, apiKey: "")
        TRPClient.monitor(data: true, url: true)
    }
    
    // MARK: - Test Functions
    
    /**
     * Test place of interest with given city id.
     */
    func testPoiWithCityId() {
        
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        var loopCounter = 0
    
        TRPRestKit().poi(withCityId: cityId, autoPagination: false) { (result, error, _) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel]  else {
                XCTFail("\(nameSpace) Json model Resultcoundn't converted.")
                return
            }
            
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            
            loopCounter += 1
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(loopCounter, 1)
    }
    
    /**
     * Test place of interest with given city id and true autoPagination params.
     */
    func testPoiWithCityIdAutoPagination() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        expectation.expectedFulfillmentCount = 2
        var loopCounter = 0
        TRPRestKit().poi(withCityId: cityId, autoPagination: true) { (result, error, _) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel]  else {
                XCTFail("\(nameSpace) Json model Resultcoundn't converted.")
                return
            }
            
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            
            loopCounter += 1
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        XCTAssertGreaterThan(loopCounter, 1)
    }
    
    /**
     * Test place of interest with given city id and placeId params.
     */
    func testPoiWithPlaceIdAndCityId() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().poi(withIds: [placeId], cityId: cityId) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel] else {
                XCTFail("\(nameSpace) Json model Resultcoundn't converted.")
                return
            }
            XCTAssertNotNil(pagination)
            XCTAssertEqual(pagination!, Pagination.completed)
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            XCTAssertEqual(firstPlace!.id, self.placeId)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Test place of interest with given url link.
     */
    func testPoiWithLink() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        let url = "\(TestUtilConstants.targetServer.url.reableUrl)/poi?city_id=41&limit=100&page=2"
        
        TRPRestKit().poi(url: url) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel] else {
                XCTFail("\(nameSpace) Json model Resultcoundn't converted.")
                return
            }
            XCTAssertNotNil(pagination)
            
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Test place of interest with given location.
     */
    func testPoiWithLocation() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().poi(withLocation: location) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel] else {
                XCTFail("\(nameSpace) Json model Resultcoundn't converted.")
                return
            }
            XCTAssertNotNil(pagination)
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Test place of interest with given cityId, far location, distance and limit.
     */
    func testPoiWithLocationAndLongDistance() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        expectation.expectedFulfillmentCount = 2
        var loopCounter = 0
        let distance = 90
        
        TRPRestKit().poi(withLocation: location, distance: Float(distance), cityId: cityId, categoryIds: categoryIds, autoPagination: true, limit: 20) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel] else {
                XCTFail("\(nameSpace) Json model coundn't converted.")
                return
            }
            
            loopCounter += 1
            XCTAssertNotNil(pagination)
            XCTAssertNotEqual(places.count, 0)
            
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        XCTAssertGreaterThan(loopCounter, 1)
    }
    
    /**
     * Test place of interest with given city Id and poiCategory Ids.
     */
    func testPoiWithCityIdPoiCategory() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().poi(withCityId: cityId, categoryIds: categoryIds) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel] else {
                XCTFail("\(nameSpace) Json model Resultcoundn't converted.")
                return
            }
            XCTAssertNotNil(pagination)
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Test place of interest search with given cityId and location.
     */
    func testPoiSearch() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        
        TRPRestKit().poi(search: "hot", cityId: cityId, location: location) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel] else {
                XCTFail("\(nameSpace) Json model coundn't converted.")
                return
            }
            XCTAssertNotNil(pagination)
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Test place of interest information with given placeId, cityId.
     */
    func testPoiInfo() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().poi(withIds: [placeId], cityId: cityId) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel] else {
                XCTFail("\(nameSpace) Json model coundn't converted.")
                return
            }
            XCTAssertNotNil(pagination)
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            XCTAssertEqual(firstPlace!.id, self.placeId)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
