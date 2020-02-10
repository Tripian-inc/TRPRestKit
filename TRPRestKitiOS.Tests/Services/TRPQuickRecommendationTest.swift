//
//  TRPQuickRecommendationTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 16.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// # TRPQuickRecommendationTest that tests recommendation functions which is used among trip operations by Rest - Kit.

import XCTest
@testable import TRPRestKit

class TRPQuickRecommendationTest: XCTestCase {
    
    // MARK: Variables
    let cityId = TestUtilConstants.MockCityConstants.IstanbulCityId
    let poiCategoryType = TestUtilConstants.MockPoiCategoryConstants.PoiCategoryType
    
    // MARK: Set Up
    override class func setUp() {
        super.setUp()
    }
    
    // MARK: Test Functions
    
    /**
     * Tests Recommendation with only given cityId parameter,
     * then checks the given recommendation id matches with the places of interest
     * in the foretold city.
     */
    func testQuickRecommendation() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        var settings = TRPRecommendationSettings(cityId: cityId)
        settings.poiCategoryIds = [poiCategoryType]
        
        TRPRestKit().quickRecommendation(settings: settings) { (result, error, _) in
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
            
            TRPRestKit().poi(withIds: [poisId.first!.id], cityId: self.cityId) { (result, error, _) in
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    return
                }
                if let places = result as? [TRPPoiInfoModel], let place = places.first {
                    if place.cityId == self.cityId {
                        expectation.fulfill()
                    } else {
                        XCTFail("\(nameSpace) cityId not equal")
                    }
                } else {
                    XCTFail("\(nameSpace) Json model couldn't converted to  [TRPRecommendationInfoJsonModel]")
                }
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
}
