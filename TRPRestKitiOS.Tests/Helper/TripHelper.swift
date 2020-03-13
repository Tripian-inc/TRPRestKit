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
    
    @Storage(key: "tripHash", defaultValue: "")
    private var storageTripHash: String
    
    
    private var createdTripHolder: TRPTripModel?
    private var poisHolder: [TRPPoiInfoModel]?
    private var poisHolderCityId: Int = 107
    
    public func getDay(order: Int) -> TRPPlansInfoModel {
        guard let trip = createdTripHolder else {
            fatalError("Trip is nil")
        }
        //Array uzunluğu test kontrolü eksik
        return trip.plans[order]
    }
    
    
    public func getTrip() -> TRPTripModel {
        if createdTripHolder == nil && storageTripHash.isEmpty{
            let newTrip = createAndFetchNewTrip()
            createdTripHolder = newTrip
            fetchAllStepsInTrip(tripHash: newTrip.tripHash, wait: 6)
            storageTripHash = newTrip.tripHash
        }else if !storageTripHash.isEmpty {
            fetchAllStepsInTrip(tripHash: storageTripHash, wait: 0)
        }
        return createdTripHolder!
    }
    
    
    private func createAndFetchNewTrip() -> TRPTripModel {
        do {
            return try TripFetcher().createTrip()
        }catch UnitTestError.isEmpty {
            fatalError("[Error] IsEmpty")
        } catch UnitTestError.trpError(let error) {
            fatalError(error)
        } catch {
            fatalError("[Error] \(error.localizedDescription)")
        }
    }
    
    
    private func fetchAllStepsInTrip(tripHash: String, wait: TimeInterval)  {
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().asyncAfter(deadline: .now() + wait) {
            do {
                self.createdTripHolder = try TripFetcher.fetchTrip(withHash: tripHash)
                semaphore.signal()
            }catch UnitTestError.isEmpty {
                fatalError("[Error] IsEmpty")
            } catch UnitTestError.trpError(let error) {
                fatalError(error)
            } catch {
                fatalError("[Error] \(error.localizedDescription)")
            }
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }
    
    
    public func getPois(cityId: Int = 107) -> [TRPPoiInfoModel] {
        UserMockSession.shared.setServer()
        checkPoisIsSomeCity(cityId: cityId)
        
        if poisHolder == nil {
            do {
                poisHolder = try TripFetcher.fetchPoiInCity(cityId)
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
    
}



