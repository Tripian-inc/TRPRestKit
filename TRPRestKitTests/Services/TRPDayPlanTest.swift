//
//  TRPDayPlanTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 12.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
import TRPRestKit

class TRPDayPlanTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    
    
    func testDayPlan() {
        
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "AddPoint"
        let dayPlanId = 97
        
        TRPRestKit().dayPlan(id: dayPlanId) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                expectation.fulfill()
                return
            }
            guard let _ = result as? TRPDayPlanJsonModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPDayPlanJsonModel")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
        }
      
        wait(for: [expectation], timeout: 10.0)
    }
    
    
}
