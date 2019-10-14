//
//  TRPRecommendationTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 11.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
import TRPRestKit

class TRPRecommendationTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    /*
    
    func testRecommendationForAnkara() {
        
        let expectation = XCTestExpectation(description: "TRPRestKit.Recommendation expectation")
        
        let rec = TRPRecommendationSettings(cityId: 112)
        TRPRestKit().recommendation(settings: rec) { (result, error,_) in
            if let error = error {
                XCTFail("Recommendation Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("Recommendation Resutl is nil")
                return
            }
            guard let jsonModel = result as? [TRPRecommendationInfoJsonModel] else {
                XCTFail("Recommendation Json model coundn't converted to  TRPCityJsonModel")
                return
            }
            
            XCTAssert(jsonModel.count > 0, "Haven't got Recommendation model")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
     */
    
}
