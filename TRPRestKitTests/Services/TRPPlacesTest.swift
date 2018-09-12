//
//  TRPPlacesTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 10.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
import TRPRestKit
import TRPFoundationKit

class TRPPlacesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    
    func testFethPlaceWithCityId() {
        let nameSpace = "TRPPlaces"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().places(withCityId: 112) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let places = result as? [TRPPlaceInfoJsonModel]  else {
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
    
    func testFethPlacesWithIds() {
        let nameSpace = "TRPRestKit().city(withPlacesId:)"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().places(withPlacesId: [1,2,3],
                            cityId: 112) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let places = result as? [TRPPlaceInfoJsonModel]  else {
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
    
    func testFethPlacesWithLocation() {
        let nameSpace = "TRPRestKit().city(withPlacesId:)"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().places(withLocation: TRPLocation(lat: 41, lon: 29)) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let places = result as? [TRPPlaceInfoJsonModel]  else {
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
    
    func testFethPlacesWithLocationDistance() {
        let nameSpace = "TRPRestKit().city(withPlacesId:)"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().places(withLocation: TRPLocation(lat: 41, lon: 29), distance: 10) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let places = result as? [TRPPlaceInfoJsonModel]  else {
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
        let nameSpace = "TRPRestKit().city(withPlacesId:)"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().places(withLocation: TRPLocation(lat: 41, lon: 29), typeId: 29) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let places = result as? [TRPPlaceInfoJsonModel]  else {
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
}

