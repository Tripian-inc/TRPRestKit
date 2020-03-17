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
        let urlCreater = BaseUrlCreater(baseUrl: "6ezq4jb2mk.execute-api.eu-west-1.amazonaws.com", basePath: "api")
        TRPClient.start(baseUrl: urlCreater, apiKey: "")
        TRPClient.monitor(data: true, url: true)
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
                let tripHash = result.tripHash
                
                TRPRestKit().getTrip(withHash: tripHash) { (currentTrip, error) in
                    
                    if let error = error {
                        XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let currentTrip = currentTrip as? TRPTripModel else {
                        XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripJsonModel")
                        return
                    }
                    
                    XCTAssertEqual(result.tripHash, currentTrip.tripHash)
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
        
        let arrival = getDaysAfter(withDays: 1)
        let departure = getDaysAfter(withDays: 3)
        let settings = TRPTripSettings(cityId: cityId, arrivalTime: arrival, departureTime: departure)
        settings.tripAnswer = [1, 2, 3]
        settings.profileAnswer = [111111, 222222, 33333]
        TRPRestKit().login(withEmail: "silV3_9@fakemailxyz.com", password: "123456aA") { (result, error) in
            XCTAssertNil(error)
            
            if let result = result as? TRPLoginTokenInfoModel {
                TRPRestKit().createTrip(settings: settings) { (result, error) in
                    
                    if let error = error {
                        XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                        expectation.fulfill()
                        return
                    }
                    
                    guard let result = result as? TRPTripModel else {
                        XCTFail("\(nameSpace) Json model coundn't converted to  TRPGenericParser<TRPTripModel>")
                        expectation.fulfill()
                        return
                    }
                    
                    XCTAssertNotNil(result)
                    XCTAssertNotNil(result.id)
                    XCTAssertGreaterThan(result.id, 0)
                    //XCTAssertEqual(result.tripProfile.departureDateTime, departure.timeForServer)
                    //XCTAssertEqual(result.tripProfile.arrivalDateTime, arrival.timeForServer)
                    XCTAssertGreaterThan(result.tripHash.count, 10)
                    XCTAssertEqual(result.city.id, self.cityId)
                    expectation.fulfill()
                }
                
            }
            
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
        
        let arrival = getNextDay()
        let departure = getDaysAfter(withDays: 3)
        let settings = TRPTripSettings(cityId: cityId, arrivalTime: arrival, departureTime: departure)
        
        TRPRestKit().createTrip(settings: settings) { (result, error) in
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            
            guard let result = result as? TRPTripModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPGenericParser<TRPTripModel>")
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsMedium) {
                let editedTripHash = result.tripHash
                let editedArrival = self.getNextDay()
                let editedDeparture = self.getDaysAfter(withDays: 8)
                let editedTripSettings = TRPTripSettings(hash: editedTripHash, arrivalTime: editedArrival, departureTime: editedDeparture)
                
                TRPRestKit().editTrip(settings: editedTripSettings) { (result, error) in
                    
                    if let error = error {
                        XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let result = result as? TRPTripModel else {
                        XCTFail("\(nameSpace) Json model coundn't converted to  TRPGenericParser<TRPTripModel>")
                        return
                    }
                    
                    XCTAssertNotNil(result)
                    XCTAssertNotNil(result.id)
                    XCTAssertGreaterThan(result.id, 0)
                    XCTAssertNotNil(result.tripHash)
                    //XCTAssertEqual(result.tripProfile.departureDateTime, editedDeparture.timeForServer)
                    //XCTAssertEqual(result.tripProfile.arrivalDateTime, editedArrival.timeForServer)
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
                let tripHash = result.tripHash
                TRPRestKit().deleteTrip(hash: tripHash) { deletedTripJson, error in
                    
                    if let error = error {
                        XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                        return
                    }
                    guard let deletedTripJson = deletedTripJson as? TRPParentJsonModel else {
                        XCTFail("\(nameSpace) Json model coundn't converted to  TRPGenericParser<TRPTripModel>")
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
