//
//  TRPPlanPointAlternativeTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 12.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
import TRPRestKit

class TRPPlanPointAlternativeTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    
    
    func testPlanPointAlternativeHash() {
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "PlanPointAlternativeHash"
        let hash = "205719567d31a2b10881ce081b99e554"
        TRPRestKit().planPointAlternatives(withHash: hash) { result, error in
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
            guard let _ = result as? [TRPPlanPointAlternativeInfoModel] else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPlanPointAlternativeId() {
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "PlanPointAlternativeId"
        TRPRestKit().planPointAlternatives(withPlanPointId: 121) { result, error in
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
            guard let _ = result as? [TRPPlanPointAlternativeInfoModel] else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
