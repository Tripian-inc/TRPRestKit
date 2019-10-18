//
//  TRPCitiesTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 11.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
@testable import TRPFoundationKit

class TRPCitiesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }

    func testCities() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        var loopCount = 0
        TRPRestKit().cities { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let cities = result as? [TRPCityInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            
            XCTAssertNotNil(pagination)
            XCTAssertNotEqual(pagination!, Pagination.completed)
            XCTAssertTrue(cities.count != 0)
            loopCount += 1
            
            print("Loop count \(loopCount)")
            //AutoCompleted true olduğu için birken fazla kez dönüyor
            if loopCount > 1 {
                expectation.fulfill()
            }
            
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCitiesWithoutAutoPagination() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        var loopCount = 0
        
        TRPRestKit().cities(isAutoPagination: false) {(result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let cities = result as? [TRPCityInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            
            XCTAssertNotNil(pagination)
            XCTAssertNotEqual(pagination!, Pagination.completed)
            XCTAssertTrue(cities.count != 0)
            loopCount += 1
            
            print("Loop count \(loopCount)")
            //AutoCompleted true olduğu için birken fazla kez dönüyor
            expectation.fulfill()
            //Test yapmak için açılacak
            if loopCount > 1 {}
            
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
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
                XCTFail("\(nameSpace) Resutl is nil")
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
    
    func testCityWithId() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        let cityId = 107
        TRPRestKit().city(with: cityId) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let city = result as? TRPCityInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPCityInfoModel")
                return
            }
            
            XCTAssertEqual(city.name, "Istanbul", "Istanbul name is not equal")
            XCTAssertEqual(city.id, cityId)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCityLocation() {
        let nameSpace = "TRPRestKit().city(with:)"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().city(with: TRPLocation(lat: 41, lon: 29)) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let city = result as? TRPCityInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPCityInfoModel")
                return
            }
            
            XCTAssertEqual(city.name, "Istanbul", "Istanbul name is not equal")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCityWithUrl() {
        
        let url = "https://0swjhnxnqd.execute-api.ca-central-1.amazonaws.com/v2/cities?limit=25&page=2"
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")

        TRPRestKit().cities(link: url) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let cities = result as? [TRPCityInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            
            XCTAssertNotNil(pagination)
            XCTAssertNotEqual(pagination!, Pagination.completed)
            XCTAssertTrue(cities.count != 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 7.0)
    }
    
}
