//
//  TRPPlanPointAlternativeTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 11.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// # TRPDailyPlanTest that tests daily plan place of interest functions operated by Rest - Kit.

import XCTest
@testable import TRPRestKit
import TRPFoundationKit

// swiftlint:disable all
class BdTRPDailyPlanTest: XCTestCase {
    
    // MARK: Variables
    private var firstDayDailyPlan: TRPPlansInfoModel? {
        return TripHelper.shared.getDay(order: 0)
        
    }
    private var lastDayDailyPlan: TRPPlansInfoModel? {
        return TripHelper.shared.getDay(order: 1)
    }
    private var mockTripHash: String? {
        return TripHelper.shared.getTrip().tripHash
    }
    
    // MARK: Set Up
    override func setUp() {
        super.setUp()
        UserMockSession.shared.setServer()
        UserMockSession.shared.doLogin()
        _ = TripHelper.shared.prepareTrip()
    }
    
    // MARK: Daily Plan Tests
    
    /**
     * Tests getDailyPlan function with dailyPlanId given.
     * <p>
     * First, gets mock trip and its DailyPlan List.
     * Then, calls the getDailyPlanFunction.
     * </p>
     */
    func testGetDailyPlan() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        guard let dailyPlanId = self.firstDayDailyPlan?.id else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
    
        TRPRestKit().dailyPlan(id: dailyPlanId) { [weak self] (dailyPlan, error) in
            guard self != nil else {return}
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            
            guard let dailyPlan = dailyPlan as? TRPPlansInfoModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPDailyPlanInfoModel")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(dailyPlan)
            XCTAssertNotNil(dailyPlan.date)
            
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 20)
    }
    
    
    // MARK: Daily Plan Poi Alternative Tests
    
    /**
     * Tests getDailyPlanPoiAlternativesWithHash function with given trip hash.
     * <p>
     * Checks the responded daily plan poi alternatives and its trip hash.
     * </p>
     */
    func testGetDailyPlanPoiAlternativesWithHash() {
        
        //TODO:TUM TEST DÜZENLENECEK. STEP KARIŞTIRDI
        /*
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        
        
        guard let mockTripHash = self.mockTripHash else{
            XCTFail("mockTripHash not equal")
            expectation.fulfill()
            return
        }
        
        TRPRestKit().planPoiAlternatives(withHash: mockTripHash) { result, error in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let _ = result else {
                XCTFail("\(nameSpace) Result is nil")
                expectation.fulfill()
                return
            }
            guard let result = result as? [TRPPlanPointAlternativeInfoModel] else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPPlanPointAlternativeInfoModel")
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(result)
            XCTAssertGreaterThan(result.count, 0)
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 20)
 */
    }
    
}
