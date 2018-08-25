//
//  TRPRestKitTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class TRPRestKitTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("c2db92dbf179338c691503f1788b3447")
    }
    
    
    func testCities()  {
        
        let expectation = XCTestExpectation(description: "TRPRestKit.cities expectation")
        
        TRPRestKit().cities { (result, error) in
            if let error = error {
                XCTFail("City Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("City Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPCityJsonModel else {
                XCTFail("City Json model coundn't converted to  TRPCityJsonModel")
                return
            }
            
            guard let citiesInfoModel = jsonModel.data else {
                XCTFail("City Json model have got no info models")
                return
            }
            
            XCTAssert(citiesInfoModel.count > 0, "Haven't got cities model")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    func testTypes() {
        let expectation = XCTestExpectation(description: "TRPRestKit.Types expectation")
        
        TRPRestKit().placeTypes { (result, error) in
            if let error = error {
                XCTFail("Types Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("Types Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPPlaceTypeJsonModel else {
                XCTFail("Types Json model coundn't converted to  TRPCityJsonModel")
                return
            }
            
            guard let citiesInfoModel = jsonModel.data else {
                XCTFail("Types Json model have got no info models")
                return
            }
            
            XCTAssert(citiesInfoModel.count > 0, "Haven't got Types model")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
