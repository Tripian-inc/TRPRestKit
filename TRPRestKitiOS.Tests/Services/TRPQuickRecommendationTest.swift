//
//  TRPQuickRecommendationTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 16.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class TRPQuickRecommendationTest: XCTestCase {
    
    let cityId = 107
    let poiCategoryType = 3
    
    override class func setUp() {
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    
    func testQuickRecommendation() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace)ExpectationStartRE")
        let expectationFetchPlace = XCTestExpectation(description: "\(nameSpace)ExpectationFetchPlace")
        var setting = TRPRecommendationSettings(cityId: cityId)
        setting.poiCategoryIds = [poiCategoryType]
        
        TRPRestKit().quickRecommendation(settings: setting) { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let poisId = result as? [TRPRecommendationInfoJsonModel]  else {
                XCTFail("\(nameSpace) Json model couldn't converted to  [TRPRecommendationInfoJsonModel]")
                return
            }
            
            XCTAssertNotEqual(poisId.count, 0)
            expectation.fulfill()
            
            TRPRestKit().poi(withIds: [poisId.first!.id], cityId: self.cityId) { (result, error, pagination) in
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    return
                }
                if let places = result as? [TRPPoiInfoModel], let place = places.first {
                    if place.cityId == self.cityId {
                        expectationFetchPlace.fulfill()
                    }else {
                        XCTFail("\(nameSpace) cityId not equal")
                    }
                }else {
                    XCTFail("\(nameSpace) Json model couldn't converted to  [TRPRecommendationInfoJsonModel]")
                }
            }
            
            
        }
        
        wait(for: [expectation,expectationFetchPlace], timeout: 10.0)
    }
    
}
