//
//  TRPPoiTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 14.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class TRPPoiTest: XCTestCase{
    
    let cityId = 107 //Istanbul
    let placeId = 516733  //David M. Arslantas istanbul
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
        TRPClient.printData(true)
    }
    
    func testPoiWithCityId() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        var loopCounter = 0
        TRPRestKit().poi(withCityId: cityId, autoPagination: false) { (result, error, pagination) in
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
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
        
            loopCounter = loopCounter + 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                if loopCounter == 1 {
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPoiWithCityIdAutoPagination() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        var loopCounter = 0
        TRPRestKit().poi(withCityId: cityId, autoPagination: true) { (result, error, pagination) in
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
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
        
            loopCounter = loopCounter + 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                if loopCounter > 1 {
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPoiWithIdCity() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expection")
        TRPRestKit().poi(withIds: [placeId], cityId: cityId) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let places = result as? [TRPPoiInfoModel] else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
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
    
    
    func testPoiWithLink() {
        let nameSpace = #function
        let expection = XCTestExpectation(description: "\(nameSpace) expection")
        
        wait(for: [expection], timeout: 10.0)
    }
    
    func testPoiWithLocation() {
        let nameSpace = #function
        let expection = XCTestExpectation(description: "\(nameSpace) expection")
        
        wait(for: [expection], timeout: 10.0)
    }
    
    func testPoiWithCategory() {
        let nameSpace = #function
        let expection = XCTestExpectation(description: "\(nameSpace) expection")
        
        wait(for: [expection], timeout: 10.0)
    }
    
    func testPoiWithLocationDistance() {
        let nameSpace = #function
        let expection = XCTestExpectation(description: "\(nameSpace) expection")
        
        wait(for: [expection], timeout: 10.0)
    }
    
    func testPoiWithLocationCategory() {
        let nameSpace = #function
        let expection = XCTestExpectation(description: "\(nameSpace) expection")
        
        wait(for: [expection], timeout: 10.0)
    }
    
    
}
