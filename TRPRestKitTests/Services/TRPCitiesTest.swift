//
//  TRPCitiesTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 10.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
@testable import TRPFoundationKit

class TRPCitiesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    
    func testFethAllCity() {
        let nameSpace = "TRPCities"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
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
            if cities.count < 1 {
                XCTFail("\(nameSpace) no exist data in array")
            }
            expectation.fulfill()
        }
    
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFethIstanbul() {
        let nameSpace = "TRPRestKit().city(with:)"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().city(with: 107) { (result, error) in
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
    
    func testFethIstanbulWithLatlon() {
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
}
