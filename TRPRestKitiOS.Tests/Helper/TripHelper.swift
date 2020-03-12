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
// swiftlint:disable all
class TripHelper: XCTestCase {
    
    static let shared = TripHelper()
    
    private var createdTripHolder: TRPTripModel?
    private var poisHolder: [TRPPoiInfoModel]?
    private var poisHolderCityId: Int = 107
    
    
    
    
    
    
    
    public func getTrip() -> TRPTripModel? {
        
        if createdTripHolder == nil {
            do {
                createdTripHolder = try createTrip()
            }catch UnitTestError.isEmpty {
                fatalError("[Error] IsEmpty")
            } catch UnitTestError.trpError(let error) { fatalError(error)
            } catch { fatalError("[Error] \(error.localizedDescription)")
            }
            
        }
        return createdTripHolder!
    }
    
    
    
    
    
    
    public func getPois(cityId: Int = 107) -> [TRPPoiInfoModel] {
        UserMockSession.shared.setServer()
        checkPoisIsSomeCity(cityId: cityId)
        
        if poisHolder == nil {
            do {
                poisHolder = try fetchPoiInCity(cityId)
            }catch UnitTestError.isEmpty {
                fatalError("[Error] IsEmpty")
            }catch UnitTestError.trpError(let error) {
                fatalError(error)
            }catch{
                fatalError("[Error] \(error.localizedDescription)")
            }
        }
        return poisHolder!
    }
    
    
    
    
    private func checkPoisIsSomeCity(cityId: Int) {
        if poisHolderCityId != cityId {
            poisHolder = nil
        }
    }
    
    
    
    func fetchPoiInCity(_ cityId: Int = 107) throws -> [TRPPoiInfoModel] {
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

//MARK: - Create Trip
extension TripHelper {
    
    
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
extension TripHelper {
    func fetchTrip(withHash hash: String) {
        TRPRestKit().getTrip(withHash: hash) { (result, error) in
            
        }
    }
}



