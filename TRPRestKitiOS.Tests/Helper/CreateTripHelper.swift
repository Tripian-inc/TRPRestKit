//
//  CreateTripHelper.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 6.03.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
import XCTest
@testable import TRPRestKit
class CreateTripHelper: XCTestCase {
    
    func create() throws -> TRPTripModel{
        let arrival = getNextDay()
        let departure = getDaysAfter(withDays: 1)
        let settings = TRPTripSettings(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId,
                                       arrivalTime: arrival,
                                       departureTime: departure)
        //CallBack içindeki errorları anlamlı hale getirir.
        var errorFromCall: UnitTestError?
        var tripInfo: TRPTripModel?
        //Async yapıyı kilitler
        let semaphore = DispatchSemaphore(value: 0)
        
        TRPRestKit().createTrip(settings: settings) {(result, error) in
            
            if let error = error {
                errorFromCall = UnitTestError.trpError(error.localizedDescription)
                semaphore.signal()
                return
            }
            
            guard let model = result as? TRPTripModel else {
                errorFromCall = .typeCasting
                semaphore.signal()
                return
            }
            tripInfo = model
            semaphore.signal()
        }
        //Semaphore un ne kadar beklemesi gerektiğini set eder.
        _ = semaphore.wait(timeout: .distantFuture)
        if errorFromCall != nil {
            throw errorFromCall!
        }
        guard let tripInfom = tripInfo else {
            throw UnitTestError.unDefined
        }
        return tripInfom
    }
}
