//
//  TRPStepTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 5.03.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit


private var addedStepForStepTest: TRPStepInfoModel?
private var edittedStepForStepTest: TRPStepInfoModel?
private var refPoiForSteptest: TRPPoiInfoModel!
private var editPoiForSteptest: TRPPoiInfoModel!

// swiftlint:disable all
class TRPStepTest: XCTestCase {
    
    override class func setUp() {
        _ = TripHelper.shared.getTrip()
    }
    
    override func setUp() {
        print("MotherFucker Prepare")
        UserMockSession.shared.setServer()
        UserMockSession.shared.doLogin()
    }
    
    private func createRefAndEditPoi()  {
        let pois = TripHelper.shared.getPois()
        if  pois.count < 10 {
            fatalError()
        }
        let refOrder = Int.random(in: 0..<pois.count - 3)
        
        refPoiForSteptest = pois[refOrder]
        editPoiForSteptest = pois[refOrder + 1]
    }
    
    
    
    //Add Step
    func testAddStepInTrip() {
        
        createRefAndEditPoi()
        
        let expect = XCTestExpectation(description: #function)
        TRPRestKit().addStep(planId: TripHelper.shared.getTrip().plans.first!.id, poiId: refPoiForSteptest.id) { (result, error) in
            if let error = error {
                XCTAssertNil(error)
                expect.fulfill()
                return
            }
            
            guard let result = result as? TRPStepInfoModel else {
                XCTFail()
                expect.fulfill()
                return
            }
            addedStepForStepTest = result
            XCTAssertEqual(result.poi.id, refPoiForSteptest.id)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
    
    
    // Edit Step
    func testEditTripStep() {
        
        guard let addedStep = addedStepForStepTest else {
            XCTFail("Added Step must not be empty")
            return
        }
        let expect = XCTestExpectation(description: #function)
        //Note: - liste boş gelirse hata verebilir
        TRPRestKit().editStep(stepId: addedStep.id, poiId: editPoiForSteptest.id) { (result, error) in
            if let error = error {
                XCTAssertNil(error)
                expect.fulfill()
                return
            }
            guard let result = result as? TRPStepInfoModel else {
                XCTFail()
                expect.fulfill()
                return
            }
            XCTAssertEqual(result.poi.id, editPoiForSteptest.id)
            edittedStepForStepTest = result
            print("Mazinga 1")
            expect.fulfill()
        }
        wait(for: [expect], timeout: 10)
    }
    
    // Delete Step
    func testDeleteTripStep() {
        /*
        print("Mazinga 2")
        guard let addedStep = addedStepForStepTest else {
            XCTFail("edittedStepForStepTest is nil")
            return
        }*/
        let expect = XCTestExpectation(description: #function)
        
        TRPRestKit().getTrip(withHash: "fa8ee328ddd44ebab5c82ddc4cc4b0a0") { (resunt, error) in
            if let error = error {
                XCTAssertNil(error)
                expect.fulfill()
                return
            }
            guard let parentResult = resunt as? TRPTripModel else {
                XCTFail()
                expect.fulfill()
                return
            }
            
            
            TRPRestKit().deleteStep(stepId: parentResult.plans.first!.id) { (result, error) in
                if let error = error {
                    XCTAssertNil(error)
                    expect.fulfill()
                    return
                }
                guard let parentResult = result as? TRPParentJsonModel else {
                    XCTFail()
                    expect.fulfill()
                    return
                }
                XCTAssert(parentResult.success)
            }
        }
        
        
        //TripHelper.shared.getTrip()!.plans.first!.id
        
        wait(for: [expect], timeout: 10)
    }
    
}
