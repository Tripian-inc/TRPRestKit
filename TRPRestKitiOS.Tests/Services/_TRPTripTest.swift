//
//  TRPTripTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 11.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class TRPTripTest: XCTestCase {
  /*
    override func setUp() {
        super.setUp()
       TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }

    
    func testCreateTrip() {
        //205719567d31a2b10881ce081b99e554
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "CreateTrip"
        let arrival = TRPTime(year: 2019, month: 01, day: 05, hours: 08, min: 00)
        let departure = TRPTime(year: 2019, month: 01, day: 08, hours: 18, min: 00)
        let settings = TRPTripSettings(cityId: 107, arrivalTime: arrival, departureTime: departure)
        
        TRPRestKit().createTrip(settings: settings) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? TRPTripJsonModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            expectation.fulfill()
        }
       
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetTrip() {
        //205719567d31a2b10881ce081b99e554
        let expectation = XCTestExpectation(description: "TRPRestKit.getProgram expectation")
        let nameSpace = "GetTrip"
        
        TRPRestKit().getTrip(withHash: "205719567d31a2b10881ce081b99e554") { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let trip = result as? TRPTripInfoModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPMyProgramsJsonModel")
                return
            }
            
            print("Trip \(trip)")
            
            expectation.fulfill()
        }
     
        wait(for: [expectation], timeout: 10.0)
    }
  
    */
    
}
