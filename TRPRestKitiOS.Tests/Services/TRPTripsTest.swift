//
//  TRPTripsTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 16.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// # TRPTripsTest that tests trip functions operated by Rest - Kit.

import XCTest
@testable import TRPRestKit

class TRPTripsTest: XCTestCase {
    
    // MARK: Variables
    private let cityId = TestUtilConstants.MockCityConstants.IstanbulCityId
    
    // MARK: Set Up
    override func setUp() {
        super.setUp()
    }
    
    // MARK: Trip Tests
    
    /**
     * Tests Get Trip
     * First, creates a new trip, and saves it's trip.
     * Then, gets created trip and checks whether they are match.
     */
    func testGetTrip() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        createMockTrip { (result, error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsMedium) {
                let tripHash = result.hash
                
                TRPRestKit().getTrip(withHash: tripHash) { (currentTrip, error) in
                    
                    if let error = error {
                        XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let currentTrip = currentTrip as? TRPTripInfoModel else {
                        XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripJsonModel")
                        return
                    }
                    
                    XCTAssertEqual(result.hash, currentTrip.hash)
                    XCTAssertEqual(result.city.id, self.cityId)
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 35.0)
    }
    
    /**
     * Tests Create Trip
     * by giving trip param as a param.
     * Then, checks whether response have the same tripParam,
     * by controlling response with the foretold trip param.
     */
    func testCreateTrip() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        let arrival = getToday()
        let departure = getDaysAfter(withDays: 3)
        let settings = TRPTripSettings(cityId: cityId, arrivalTime: arrival, departureTime: departure)
        
        TRPRestKit().createTrip(settings: settings) { (result, error) in
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            
            guard let result = result as? TRPTripInfoModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripJsonModel")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.id)
            XCTAssertGreaterThan(result.id, 0)
            XCTAssertNotNil(result.arrivalTime)
            XCTAssertNotNil(result.depatureTime)
            XCTAssertNotNil(result.hash)
            XCTAssertEqual(result.arrivalTime?.date, arrival.date)
            XCTAssertEqual(result.depatureTime?.date, departure.date)
            XCTAssertEqual(result.city.id, self.cityId)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Tests Edit Trip
     * First, creates a new trip, and saves it's trip hash.
     * Then, edits created trip by giving new trip params and created trip hash as a parameter.
     */
    func testEditTrip() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        let arrival = getToday()
        let departure = getDaysAfter(withDays: 3)
        let settings = TRPTripSettings(cityId: cityId, arrivalTime: arrival, departureTime: departure)
        
        TRPRestKit().createTrip(settings: settings) { (result, error) in
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            
            guard let result = result as? TRPTripInfoModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripJsonModel")
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsMedium) {
                let editedTripHash = result.hash
                let editedArrival = self.getToday()
                let editedDeparture = self.getDaysAfter(withDays: 8)
                let editedTripSettings = TRPTripSettings(hash: editedTripHash, arrivalTime: editedArrival, departureTime: editedDeparture)
                
                TRPRestKit().editTrip(settings: editedTripSettings) { (result, error) in
                    
                    if let error = error {
                        XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let result = result as? TRPTripInfoModel else {
                        XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripJsonModel")
                        return
                    }
                    
                    XCTAssertNotNil(result)
                    XCTAssertNotNil(result.id)
                    XCTAssertGreaterThan(result.id, 0)
                    XCTAssertNotNil(result.arrivalTime)
                    XCTAssertNotNil(result.depatureTime)
                    XCTAssertNotNil(result.hash)
                    XCTAssertEqual(result.hash, editedTripHash)
                    XCTAssertEqual(result.arrivalTime?.date, editedArrival.date)
                    XCTAssertEqual(result.depatureTime?.date, editedDeparture.date)
                    XCTAssertEqual(result.city.id, self.cityId)
                    expectation.fulfill()
                    
                }
                
            }
        }
        
        wait(for: [expectation], timeout: 35.0)
    }
    
    /**
     * Tests Delete Trip
     * First, creates a new trip, and saves it's trip.
     * Then, gets created trip and deletes it by using it's trip hash.
     * Then, calls get trip function by using deleted trip's hash and checks whether trip exists or not.
     */
    func testDeleteTrip() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        createMockTrip { (result, error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsMedium) {
                let tripHash = result.hash
                TRPRestKit().deleteTrip(hash: tripHash) { deletedTripJson, error in
                    
                    if let error = error {
                        XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                        return
                    }
                    guard let deletedTripJson = deletedTripJson as? TRPParentJsonModel else {
                        XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripJsonModel")
                        return
                    }
                    
                    XCTAssertEqual(deletedTripJson.status, 200)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        TRPRestKit().getTrip(withHash: tripHash) { (_, error) in
                            
                            guard let  error = error else {
                                XCTFail("\(nameSpace) Parser Fail: \(nameSpace)")
                                return
                            }
                            
                            XCTAssertEqual(error.code, 404)
                            expectation.fulfill()
                        }
                    }
                }
            }
        }
        
        wait(for: [expectation], timeout: 35.0)
    }
}
