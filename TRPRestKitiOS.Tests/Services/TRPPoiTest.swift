//
//  TRPPoiTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 14.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
@testable import TRPFoundationKit
class TRPPoiTest: XCTestCase{
    
    let cityId = 107 //Istanbul
    let placeId = 516733  //David M. Arslantas istanbul
    let location = TRPLocation(lat: 41, lon: 29)
    let category = 3
    
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
        TRPClient.printData(true)
    }
    
    func testPoiWithCityId() {
        
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation4567890*09876")
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
            expectation.fulfill()
            
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
        let expectation = XCTestExpectation(description: "\(nameSpace) expection")
        let url = "https://0swjhnxnqd.execute-api.ca-central-1.amazonaws.com/v2/poi?city_id=107&limit=100&page=2"
        TRPRestKit().poi(link: url) { (result, error, pagination) in
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
            
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPoiWithLocation() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expection")
        
        TRPRestKit().poi(withLocation: location) { (result, error, pagination) in
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
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPoiWithCategory() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expection")
        
        TRPRestKit().poi(withLocation: location, categoryIds: [category]) { (result, error, pagination) in
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
            
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            let mType = firstPlace!.category.filter { (restType) -> Bool in
                if restType.id == self.category {
                    return true
                }
                return false
            }
            XCTAssertNotEqual(mType.count,0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    

    func testPoiWithLocationDistance() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expection")
         
        TRPRestKit().poi(withCityId: cityId, categoryIds: [category], autoPagination: true) { (result, error, pagination) in
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
            
            XCTAssertNotEqual(places.count, 0)
            let firstPlace = places.first
            XCTAssertNotNil(firstPlace)
            XCTAssertNotNil(firstPlace!.cityId)
            XCTAssertEqual(firstPlace!.cityId, self.cityId)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
}
