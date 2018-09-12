//
//  TRPPlanPoints.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 12.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
import TRPRestKit

class TRPPlanPoints: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    
    
    func testAddPoint() {
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "AddPoint"
        let hash = "205719567d31a2b10881ce081b99e554"
        let dayId = 97
        let placeId = 2
        TRPRestKit().addPlanPoints(hash: hash, dayId: dayId, placeId: placeId) { (result, error) in
            
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
            guard let _ = result as? TRPPlanPointInfoModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateDayPoint() {
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "UpdateDayPoint"
        let dayId = 97
        let placeId = 1
        let planPointsId = 121
        TRPRestKit().updatePlanPoints(id: planPointsId, dayId: dayId, placeId: placeId, order: 5) { (result, error) in
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
            guard let _ = result as? TRPPlanPointInfoModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeleteDayPoint() {
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "DeleteDayPoint"
        
        let planPointsId = 125
        TRPRestKit().deletePlanPoints(id: planPointsId) { (result, error) in
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
            guard let _ = result as? TRPParentJsonModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 10.0)
    }
}
