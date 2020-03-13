//
//  TRPStepAlternative.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 13.03.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
import XCTest
@testable import TRPRestKit
// swiftlint:disable all
class TRPStepAlternative: XCTestCase {
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
    
    // MARK: Daily Plan Poi Alternative Tests
    
    /**
     * Tests getDailyPlanPoiAlternativesWithHash function with given trip hash.
     * <p>
     * Checks the responded daily plan poi alternatives and its trip hash.
     * </p>
     */
    func testAllAlternativeInTrip() {
    
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        guard let mockTripHash = self.mockTripHash else{
            XCTFail("mockTripHash not equal")
            expectation.fulfill()
            return
        }
        
        TRPRestKit().stepAlternatives(withHash: mockTripHash) { result, error in
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
            
            
            guard let result = result as? [TRPStepAlternativeInfoModel] else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPPlanPointAlternativeInfoModel")
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(result)
            XCTAssertGreaterThan(result.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20)
        
    }
    
    
    /**
     * Tests testGetDailyPlanPoiAlternativesWithDailyPlan function with given first days daily plan id.
     * <p>
     * Checks the responded daily plan poi alternatives and its trip hash.
     * </p>
     */
    func testGetDailyPlanPoiAlternativesWithDailyPlan() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        guard let firstDaysDailyPlanId = self.firstDayDailyPlan?.id else{
            XCTFail("firstDayDailyPlan?.id not equal")
            expectation.fulfill()
            return
        }
        
        TRPRestKit().stepAlternatives(withPlanId: firstDaysDailyPlanId) {[weak self] (result, error) in
            guard self != nil else {return}
            
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
            
            guard let result = result as? [TRPStepAlternativeInfoModel] else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPPlanPointAlternativeInfoModel")
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(result)
            XCTAssertGreaterThan(result.count, 0)
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 20)
    }
    
    /**
     * Tests getDailyPlanPoiAlternativesWithDailyPlanPoi function with given daily plan place id.
     * <p>
     * Checks the responded daily plan poi alternatives and its trip hash.
     * </p>
     */
    
    func testGetDailyPlanPoiAlternativesWithDailyPlanPoi() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        guard let firstDaysDailyPlanId = self.firstDayDailyPlan?.id else{
            return
        }
        
        TRPRestKit().planPoiAlternatives(withDailyPlanId: firstDaysDailyPlanId) {[weak self] (result, error) in
            guard self != nil else {return}
            
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
            guard let result = result as? [TRPPlanStepAlternativeInfoModel] else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPPlanPointAlternativeInfoModel")
                expectation.fulfill()
                return
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20)
    }
}
