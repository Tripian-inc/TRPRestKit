//
//  TRPCitiesTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 11.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// # TRPCitiesTest class which tests cities functions operated by Rest - Kit.

import XCTest
@testable import TRPRestKit
import TRPFoundationKit

class BbTRPCitiesTest: XCTestCase {
    
    // MARK: Variables
    private let fourSeconds: Double = 4.0
    
    // MARK: Set Up
    override func setUp() {
        super.setUp()
    }
    
    // MARK: Test Functions
    
    /**
     * Test Cities with no parameter given.
     */
    func testCities() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        expectation.expectedFulfillmentCount = 2
        var loopCount = 0
        TRPRestKit().cities { (result, error, pagination) in
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
            guard let cities = result as? [TRPCityInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(pagination)
            //XCTAssertNotEqual(pagination!, Pagination.completed)
            XCTAssertTrue(cities.count != 0)
            loopCount += 1
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertGreaterThan(loopCount, 1)
    }
    
    /**
     * Test Cities with 100 limit.
     */
    func testCitiesLimit100() {
        
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        let limit = 100
        TRPRestKit().cities(limit: limit) { (result, error, pagination) in
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let cities = result as? [TRPCityInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            
            XCTAssertNotNil(pagination)
            //XCTAssertNotEqual(pagination!, Pagination.completed)
            XCTAssertEqual(cities.count, limit)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    /**
     * Test Cities with given false to isAutoPagination param,
     * And thus, function should be operated only once.
     */
    func testCitiesWithoutAutoPagination() {
        
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        expectation.expectedFulfillmentCount = 1
        var loopCount = 0
        
        TRPRestKit().cities(isAutoPagination: false) {(result, error, pagination) in
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            
            guard let cities = result as? [TRPCityInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            
            XCTAssertNotNil(pagination)
            //XCTAssertNotEqual(pagination!, Pagination.completed)
            XCTAssertTrue(cities.count != 0)
            
            loopCount += 1
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(loopCount, 1)
    }
    
    /**
     * Test Cities with given true to isAutoPagination param.
     * And thus, function should be operated more than once.
     */
    func testCitiesWithAutoPagination() {
        
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        expectation.expectedFulfillmentCount = 2
        var loopCount = 0
        
        TRPRestKit().cities(isAutoPagination: true) {(result, error, pagination) in
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            
            guard let cities = result as? [TRPCityInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            
            XCTAssertNotNil(pagination)
            XCTAssertTrue(cities.count != 0)
            
            loopCount += 1
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertGreaterThan(loopCount, 1)
    }
    
    /**
     * Check if the given city matches with the response by adding cityId params.
     */
    func testCityWithId() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().city(with: TestUtilConstants.MockCityConstants.IstanbulCityId) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let city = result as? TRPCityInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPCityInfoModel")
                return
            }
            
            XCTAssertEqual(city.name, TestUtilConstants.MockCityConstants.IstanbulCityName, "\(TestUtilConstants.MockCityConstants.IstanbulCityName) name is not equal")
            XCTAssertEqual(city.id, TestUtilConstants.MockCityConstants.IstanbulCityId)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Check if the given city latitude and longitude matches with the response.
     */
    func testCityLocation() {
        let nameSpace = "TRPRestKit().city(with:) \(TestUtilConstants.MockCityConstants.IstanbulCityName) "
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().city(with: TRPLocation(lat: TestUtilConstants.MockCityConstants.Istanbullocation.lat, lon: TestUtilConstants.MockCityConstants.Istanbullocation.lon)) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            guard let city = result as? TRPCityInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  \(result.self)")
                return
            }
            
            XCTAssertEqual(city.name, "Istanbul", "Istanbul name is not equal")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Test getCitiesWithLink function with given link.
     */
    func testCityWithUrlLink() {
        
        let url = "\(TestUtilConstants.targetServer.url.reableUrl)/cities?limit=20&page=2"
        print(url)
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().cities(url: url) { (result, error, pagination) in
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
            guard let cities = result as? [TRPCityInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(pagination)
            ///XCTAssertNotEqual(pagination!, Pagination.completed)
            XCTAssertTrue(cities.count != 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 7.0)
    }
}
