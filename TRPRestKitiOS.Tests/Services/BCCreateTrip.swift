//
//  BCCreateTrip.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 23.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class BcCreateTrip: XCTestCase {
    
    override func setUp() {
        /*TestUtilConstants.targetServer = .test
        TRPRestKit().logout()
        UserMockSession.shared.setServer()
        UserMockSession.shared.doLogin()
        TRPClient.monitor(data: true, url: true) */
    }

    func testCreateTripForIstanbul() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        let arrival = getToday()
        let departure = getDaysAfter(withDays: 1)
        let settings = TRPTripSettings(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId,
                                       arrivalTime: arrival,
                                       departureTime: departure)
        TRPRestKit().createTrip(settings: settings) {(result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let tripInfo = result as? TRPTripInfoModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripInfoModel")
                expectation.fulfill()
                return
            }
            // Wait 6 second for all trip created.
            
            XCTAssert(tripInfo.id != 0)
            XCTAssert(!tripInfo.hash.isEmpty)
            XCTAssertEqual(tripInfo.city.id, TestUtilConstants.MockCityConstants.IstanbulCityId)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.fetchCurrentTripToUseOther(expectation: expectation, tripHash: tripInfo.hash)
                
            }
        }
        wait(for: [expectation], timeout: 17.0)
    }
    
    private func fetchCurrentTripToUseOther(expectation: XCTestExpectation, tripHash: String) {
        TRPRestKit().getTrip(withHash: tripHash) { (currentTrip, error) in
            if let error = error {
                XCTFail(" Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            
            guard let currentTrip = currentTrip as? TRPTripInfoModel else {
                XCTFail(" Json model coundn't converted to  TRPTripJsonModel")
                expectation.fulfill()
                return
            }
            if let firstDay = currentTrip.dailyPlans?.first, let second = currentTrip.dailyPlans?[1] {
                if firstDay.generate == 1 && second.generate == 1 {
                    TripHolder.shared.model = currentTrip
                    expectation.fulfill()
                }else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.fetchCurrentTripToUseOther(expectation: expectation, tripHash: tripHash)
                    }
                }
            }else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.fetchCurrentTripToUseOther(expectation: expectation, tripHash: tripHash)
                }
            }
        }
    }
    
}
