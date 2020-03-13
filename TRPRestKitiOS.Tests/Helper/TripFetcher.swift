//
//  TripFetcher.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 13.03.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
// swiftlint:disable all
class TripFetcher: XCTestCase { }

//MARK: - Create Trip
extension TripFetcher {
    
    
    /// Trip generate eder. Bunu senktron bir şekilde yaptığı için bekledir.
    func createTrip() throws -> TRPTripModel {
        UserMockSession.shared.setServer()
        let arrival = getNextDay()
        let departure = getDaysAfter(withDays: 3)
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


//MARK: - Fetch Trip
extension TripFetcher {
    
    
    //Trip' i tekrar çeker.
    //Cünkü trip içindeki günler tamamen oluşturulmamış olabilir.
    static func fetchTrip(withHash hash: String) throws -> TRPTripModel{
        print("GET TRIP")
        var errorFromCall: UnitTestError?
        var tripData: TRPTripModel?
        
        //Semaphore kur
        let semaphore = DispatchSemaphore(value: 0)
        
        TRPRestKit().getTrip(withHash: hash) { (result, error) in
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
            tripData = model
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
        if errorFromCall != nil {
            throw errorFromCall!
        }
        guard let tripInfom = tripData else {
            throw UnitTestError.unDefined
        }
        
        return tripInfom
    }
}


//MARK : - Fetch poi in city
extension TripFetcher {
    
    static func fetchPoiInCity(_ cityId: Int = 107) throws -> [TRPPoiInfoModel] {
        //CallBack içindeki errorlar için
        var errorFromCall: UnitTestError?
        //
        var pois: [TRPPoiInfoModel] = []
        
        let semaphore = DispatchSemaphore(value: 0)
        TRPRestKit().poi(withCityId: cityId, limit: 100, autoPagination: false) { (result, error, _)  in
            if let error = error {
                errorFromCall = .trpError(error.localizedDescription)
                semaphore.signal()
                return
            }
            guard let data = result as? [TRPPoiInfoModel] else {
                errorFromCall = .typeCasting
                semaphore.signal()
                return
            }
            
            pois = data
            semaphore.signal()
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        if errorFromCall != nil {
            throw errorFromCall!
        }
        
        if pois.count == 0 { throw UnitTestError.isEmpty }
        
        return pois
    }
    
}
