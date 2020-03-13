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
        _ = TripHelper.shared.getTrip()
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
        
        guard let currentTripHash = self.mockTripHash else {
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
        
        
        guard let dailyPlanId = self.firstDayDailyPlan?.id else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        guard let currentTripHash = self.mockTripHash else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        let mockStartTime = "10:00"
        let mockEndTime = "21:00"
        
        TRPRestKit().updateDailyPlanHour(dailyPlanId: dailyPlanId, start: mockStartTime, end: mockEndTime) { [weak self] (dailyPlan, error) in
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
            XCTAssertEqual(dailyPlan.startTime, mockStartTime)
            XCTAssertEqual(dailyPlan.endTime, mockEndTime)
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 20)
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
        
        //TODO:TUM TEST DÜZENLENECEK. STEP KARIŞTIRDI
        
        /*
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        guard let dailyPlanId = lastDayDailyPlan?.id else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        guard let currentTripHash = self.mockTripHash else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        guard let firstPlaceIdOfFirstDay = self.firstDayDailyPlan?.steps.first?.poi.id else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        TRPRestKit().addPlanPoints(hash: currentTripHash, dailyPlanId: dailyPlanId, poiId: firstPlaceIdOfFirstDay) { (planPoi, error) in
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            
            
            guard let planPoi = planPoi as? TRPStepInfoModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPDailyPlanInfoModel")
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(planPoi)
            XCTAssertGreaterThan(planPoi.id, 0)
            //XCTAssertGreaterThan(planPoi.poiId, 0)
            //XCTAssertEqual(planPoi.poiId, firstPlaceIdOfFirstDay)
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 20) */
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
        //TODO:TUM TEST DÜZENLENECEK. STEP KARIŞTIRDI
        /*
        
        guard let dailyPlanId = TripHolder.shared.getDay(order: 0)?.id else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        guard let firstPlaceOfFirstDay = self.firstDayDailyPlan?.steps.first else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        TRPRestKit().deleteDailyPlanPoi(planPoiId: firstPlaceOfFirstDay.id) {[weak self] (result, error) in
            guard let strongSelf = self else {return}
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            
            guard let planPoi = result as? TRPParentJsonModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPParentJsonModel")
                expectation.fulfill()
                return
            }
            XCTAssertEqual(planPoi.status, 200)
            strongSelf.refreshDailyPlan(dailyPlanId: dailyPlanId) { (dailyPlan, error) in
                //TODO: - YENİDEN YAZILACAK
                
                if(dailyPlan.steps.contains(firstPlaceOfFirstDay)){
                    XCTFail("\(nameSpace) could not delete daily plan poi")
                    expectation.fulfill()
                    return
                }else{
                    expectation.fulfill()
                }
                
            }
        }
        
        wait(for: [expectation], timeout: 20)
 */
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
        //TODO:TUM TEST DÜZENLENECEK. STEP KARIŞTIRDI
        /*
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        
        guard let dailyPlanId = self.firstDayDailyPlan?.id else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        guard let firstPlaceOfFirstDay = self.firstDayDailyPlan?.steps.last else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        guard let firstPlaceOfLastDay = self.lastDayDailyPlan?.steps.last else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        TRPRestKit().replacePlanPoiFrom(dailyPlanPoiId: firstPlaceOfFirstDay.id, poiId: firstPlaceOfLastDay.poi.id) {[weak self] (result, error) in
            guard let strongSelf = self else {return}
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let planPoi = result as? TRPPlanPoi else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPParentJsonModel")
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(planPoi)
            strongSelf.refreshDailyPlan(dailyPlanId: dailyPlanId) { (dailyPlan, error) in
                if(dailyPlan.planPois.contains(firstPlaceOfFirstDay)){
                    XCTFail("\(nameSpace) could not delete daily plan poi")
                    expectation.fulfill()
                    return
                }else{
                    expectation.fulfill()
                }
            }
            
        }
        
        wait(for: [expectation], timeout: 20)
 
 */
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
        //TODO:TUM TEST DÜZENLENECEK. STEP KARIŞTIRDI
        /*let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        guard let dailyPlanId = self.firstDayDailyPlan?.id else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        guard let firstDaysDailyPlanPoiWhichWillBeReplaced = self.firstDayDailyPlan?.steps.last else {
            XCTFail("\(nameSpace) Daily plan is not generated yet.")
            expectation.fulfill()
            return
        }
        
        let firstDaysFirstPlaceId = firstDaysDailyPlanPoiWhichWillBeReplaced.poi.id
        let order = (self.firstDayDailyPlan?.steps.count)! - 2;
        
        TRPRestKit().reOrderPlanPoiFrom(dailyPlanPoiId: firstDaysDailyPlanPoiWhichWillBeReplaced.id,
                                        poiId: firstDaysFirstPlaceId,
                                        order: order) { [weak self] (result, error) in
            guard let strongSelf = self else {return}
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let planPoi = result as? TRPPlanPoi else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPParentJsonModel")
                expectation.fulfill()
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
        
        
        wait(for: [expectation], timeout: 20) */
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
            guard let result = result as? [TRPPlanPointAlternativeInfoModel] else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPPlanPointAlternativeInfoModel")
                expectation.fulfill()
                return
            }
            
            expectation.fulfill()
        }
        
        
        
        wait(for: [expectation], timeout: 20)
    }
}
