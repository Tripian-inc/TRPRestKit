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
class TRPDailyPlanTest: XCTestCase {
    
    // MARK: Variables
    private var firstDayDailyPlan: TRPDailyPlanInfoModel?
    private var lastDayDailyPlan: TRPDailyPlanInfoModel?
    private var mockTripHash: String?
    
    // MARK: Set Up
    override func setUp() {
        super.setUp()
        UserMockSession.shared.doLogin()
        createMockTrip { (result, _ ) in
            
            self.mockTripHash = result.hash
            guard let mockTripHash = self.mockTripHash else{
                return
            }
            
            self.firstDayDailyPlan = result.dailyPlans?.first
            self.lastDayDailyPlan = result.dailyPlans?.last
            DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsMedium) {
                self.getMockTrip(tripHash: mockTripHash) { (result, _) in
                    self.firstDayDailyPlan = result.dailyPlans?.first
                    self.lastDayDailyPlan = result.dailyPlans?.last
                }
            }
        }
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsLong) {
            guard let dailyPlanId = self.firstDayDailyPlan?.id else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            guard let currentTripHash = self.mockTripHash else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            TRPRestKit().dailyPlan(id: dailyPlanId) { [weak self] (dailyPlan, error) in
                guard self != nil else {return}
                
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    return
                }
                
                guard let dailyPlan = dailyPlan as? TRPDailyPlanInfoModel else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPDailyPlanInfoModel")
                    return
                }
                
                XCTAssertNotNil(dailyPlan)
                XCTAssertNotNil(dailyPlan.date)
                XCTAssertEqual(dailyPlan.hash, currentTripHash)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 55.0)
    }
    
    /**
     * Tests updateDailyPlan function with dailyPlanId given.
     * <p>
     * First, gets mock trip and its DailyPlan List.
     * Then, updates the first daily plan with given dailyPlanId, startTime and endTime parameter.
     * <p>
     * Then, checks the parameters of response with the given update information.
     * Then, refreshes the same day and checks the data.
     * </p>
     */
    func testUpdateDailyPlan() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsLong) {
            guard let dailyPlanId = self.firstDayDailyPlan?.id else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            guard let currentTripHash = self.mockTripHash else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            let mockStartTime = "10:00"
            let mockEndTime = "21:00"
            
            TRPRestKit().updateDailyPlanHour(dailyPlanId: dailyPlanId, start: mockStartTime, end: mockEndTime) { [weak self] (dailyPlan, error) in
                guard self != nil else {return}
                
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    return
                }
                
                guard let dailyPlan = dailyPlan as? TRPDailyPlanInfoModel else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPDailyPlanInfoModel")
                    return
                }
                
                XCTAssertNotNil(dailyPlan)
                XCTAssertNotNil(dailyPlan.date)
                XCTAssertEqual(dailyPlan.hash, currentTripHash)
                XCTAssertEqual(dailyPlan.startTime, mockStartTime)
                XCTAssertEqual(dailyPlan.endTime, mockEndTime)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 55.0)
    }
    
    // MARK: Daily Plan Poi Tests
    
    /**
     * Tests addDailyPlan function with given dailyPlanId, placeId and trip hash.
     * <p>
     * First, gets mock trip and its DailyPlan List.
     * Then, gets the first place of the first day and adds it to the last day.
     * <p>
     * Then, compares if the first place is in last day.
     * </p>
     */
    func testAddDailyPlanPoi() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsLong) {
            guard let dailyPlanId = self.lastDayDailyPlan?.id else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            guard let currentTripHash = self.mockTripHash else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            guard let firstPlaceIdOfFirstDay = self.firstDayDailyPlan?.planPois.first?.poiId else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            TRPRestKit().addPlanPoints(hash: currentTripHash, dailyPlanId: dailyPlanId, poiId: firstPlaceIdOfFirstDay) {[weak self] (planPoi, error) in
                guard self != nil else {return}
                
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    return
                }
                
                guard let planPoi = planPoi as? TRPPlanPoi else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPDailyPlanInfoModel")
                    return
                }
                XCTAssertNotNil(planPoi)
                XCTAssertGreaterThan(planPoi.id, 0)
                XCTAssertGreaterThan(planPoi.poiId, 0)
                XCTAssertEqual(planPoi.poiId, firstPlaceIdOfFirstDay)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 55.0)
    }
    
    
    /**
     * Tests deleteDailyPlanPoi function with given dailyPlanId.
     * <p>
     * First, gets mock trip and its DailyPlan List.
     * Then, deletes first place of the first day in the trip.
     * <p>
     * After, checks whether first day's plan still includes first place or not.
     * </p>
     */
    func testDeleteDailyPlanPoi() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsLong) {
            guard let dailyPlanId = self.firstDayDailyPlan?.id else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            guard let firstPlaceOfFirstDay = self.firstDayDailyPlan?.planPois.first else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            TRPRestKit().deleteDailyPlanPoi(planPoiId: firstPlaceOfFirstDay.id) {[weak self] (result, error) in
                guard let strongSelf = self else {return}
                
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    return
                }
                
                guard let planPoi = result as? TRPParentJsonModel else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPParentJsonModel")
                    return
                }
                XCTAssertEqual(planPoi.status, 200)
                strongSelf.refreshDailyPlan(dailyPlanId: dailyPlanId) { (dailyPlan, error) in
                    if(dailyPlan.planPois.contains(firstPlaceOfFirstDay)){
                        XCTFail("\(nameSpace) could not delete daily plan poi")
                        return
                    }else{
                        expectation.fulfill()
                    }
                }
            }
        }
        
        wait(for: [expectation], timeout: 100.0)
    }
    
    /**
     * Tests replaceDailyPlanPoi function with given dailyPlanPoiId,
     * and new place Id which will be replaced by.
     * <p>
     * First, gets mock trip and its DailyPlan List.
     * Then, gets second day's daily plan,
     * then changes it with first days first place
     * by using first day's daily plan poi id.
     * <p>
     * After, checks whether first place of first day
     * exists in second day.
     * </p>
     */
    func testReplaceDailyPlanPoi() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsLong) {
            guard let dailyPlanId = self.firstDayDailyPlan?.id else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            guard let firstPlaceOfFirstDay = self.firstDayDailyPlan?.planPois.first else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            guard let firstPlaceOfLastDay = self.lastDayDailyPlan?.planPois.first else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            TRPRestKit().replacePlanPoiFrom(dailyPlanPoiId: firstPlaceOfFirstDay.id, poiId: firstPlaceOfLastDay.poiId) {[weak self] (result, error) in
                guard let strongSelf = self else {return}
                
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    return
                }
                guard let planPoi = result as? TRPPlanPoi else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPParentJsonModel")
                    return
                }
                XCTAssertNotNil(planPoi)
                strongSelf.refreshDailyPlan(dailyPlanId: dailyPlanId) { (dailyPlan, error) in
                    if(dailyPlan.planPois.contains(firstPlaceOfFirstDay)){
                        XCTFail("\(nameSpace) could not delete daily plan poi")
                        return
                    }else{
                        expectation.fulfill()
                    }
                }
            }
        }
        
        wait(for: [expectation], timeout: 100.0)
    }
    
    /**
     * Tests updateDailyPlanPoiOrder function with given dailyPlanPoiId,
     * its place and place's new order digit which will be replaced by.
     * <p>
     * First, gets mock trip and its DailyPlan List.
     * Then, gets first day's daily plan, and first place of first day.
     * Then, changes it with the last order number of the current day.
     * <p>
     * After, checks whether first place of first day
     * is in last order.
     * </p>
     */
    func testUpdateDailyPlanPoiOrder() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsLong) {
            guard let dailyPlanId = self.firstDayDailyPlan?.id else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            guard let firstDaysDailyPlanPoiWhichWillBeReplaced = self.firstDayDailyPlan?.planPois.first else {
                XCTFail("\(nameSpace) Daily plan is not generated yet.")
                return
            }
            
            let firstDaysFirstPlaceId = firstDaysDailyPlanPoiWhichWillBeReplaced.poiId
            let order = (self.firstDayDailyPlan?.planPois.count)! - 1;
            
            TRPRestKit().reOrderPlanPoiFrom(dailyPlanPoiId: firstDaysDailyPlanPoiWhichWillBeReplaced.id, poiId: firstDaysFirstPlaceId, order: order) { [weak self] (result, error) in
                guard let strongSelf = self else {return}
                
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    return
                }
                guard let planPoi = result as? TRPPlanPoi else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPParentJsonModel")
                    return
                }
                
                XCTAssertNotNil(planPoi)
                strongSelf.refreshDailyPlan(dailyPlanId: dailyPlanId) { (dailyPlan, error) in
                    let lastPlaceOfFirstDay = dailyPlan.planPois.last
                    if(lastPlaceOfFirstDay?.poiId == firstDaysFirstPlaceId){
                        expectation.fulfill()
                    }
                }
            }
        }
        
        wait(for: [expectation], timeout: 100.0)
    }
    
    // MARK: Daily Plan Poi Alternative Tests
    
    /**
     * Tests getDailyPlanPoiAlternativesWithHash function with given trip hash.
     * <p>
     * Checks the responded daily plan poi alternatives and its trip hash.
     * </p>
     */
    func testGetDailyPlanPoiAlternativesWithHash() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsLong) {
            
            guard let mockTripHash = self.mockTripHash else{
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
        }
        
        wait(for: [expectation], timeout: 30.0)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsLong) {
            
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
                guard let result = result as? [TRPPlanPointAlternativeInfoModel] else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPPlanPointAlternativeInfoModel")
                    expectation.fulfill()
                    return
                }
                XCTAssertNotNil(result)
                XCTAssertGreaterThan(result.count, 0)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsLong) {
            
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
                guard let result = result as? [TRPPlanPointAlternativeInfoModel] else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPPlanPointAlternativeInfoModel")
                    expectation.fulfill()
                    return
                }
                
                guard let firstDaysDailyPlanPoiId = result.first?.dailyPlanPoi?.id else{
                    return
                }
                TRPRestKit().planPoiAlternatives(withPlanPointId: firstDaysDailyPlanPoiId) {[weak self] (result, error) in
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
                    guard let result = result as? [TRPPlanPointAlternativeInfoModel] else {
                        XCTFail("\(nameSpace) Json model coundn't converted to  TRPPlanPointAlternativeInfoModel")
                        expectation.fulfill()
                        return
                    }
                    XCTAssertNotNil(result)
                    XCTAssertGreaterThan(result.count, 0)
                    expectation.fulfill()
                }
            }
            
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
}
