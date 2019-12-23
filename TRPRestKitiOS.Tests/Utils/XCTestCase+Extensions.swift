//
//  TestUtilExtensions.swift
//  TRPRestKitiOS.Tests
//
//  Created by Rozeri Dağtekin on 10/28/19.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//
import XCTest
@testable import TRPRestKit
import TRPFoundationKit
// swiftlint:disable all
extension XCTestCase {
    
    public func changeServer(enviroment: Environment) {
        var apiKey = ""
        switch enviroment {
        case .production:
            apiKey = TestUtilConstants.ApiKeys.Product
        case .sandbox:
            apiKey = TestUtilConstants.ApiKeys.SandBox
        case .test:
            apiKey = TestUtilConstants.ApiKeys.Test
        }
        TRPClient.start(enviroment: enviroment, apiKey: apiKey)
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
    
    func toString(array: [Int]) -> String {
        return array.map { String($0) }.joined(separator: ",")
    }
    
    func getToday() -> TRPTime {
        let date = Date()
        let calendar = Calendar.current
        return TRPTime(year: calendar.component(.year, from: date), month: calendar.component(.month, from: date), day: calendar.component(.day, from: date), hours: 08, min: 00)
    }
    
    func getDaysAfter(withDays day: Int) -> TRPTime {
        let date = Date().addingTimeInterval(TimeInterval(day*60*60*24))
        let calendar = Calendar.current
        return TRPTime(year: calendar.component(.year, from: date), month: calendar.component(.month, from: date), day: calendar.component(.day, from: date), hours: 18, min: 00)
    }
    
    func createMockTrip (completionHandler: @escaping(_ result: TRPTripInfoModel, _ error: Error?) -> Void) {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        let arrival = getToday()
        let departure = getDaysAfter(withDays: 1)
        let settings = TRPTripSettings(cityId: TestUtilConstants.MockCityConstants.IstanbulCityId, arrivalTime: arrival, departureTime: departure)
        
        TRPRestKit().createTrip(settings: settings) {(result, error) in
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            
            guard let result = result as? TRPTripInfoModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripInfoModel")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
            completionHandler(result, error)
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    func getMockTrip (tripHash: String, completionHandler: @escaping(_ result: TRPTripInfoModel, _ error: Error?) -> Void){
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().getTrip(withHash: tripHash) {(result, error) in
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            
            guard let result = result as? TRPTripInfoModel else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripInfoModel")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
            completionHandler(result, error)
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    func refreshDailyPlan (dailyPlanId: Int, completionHandler: @escaping(_ result: TRPDailyPlanInfoModel, _ error: Error?) -> Void){
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + TestUtilConstants.MockTimeConstants.SecondsMedium) {
            
            TRPRestKit().dailyPlan(id: dailyPlanId) { (dailyPlan, error) in
                
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    expectation.fulfill()
                    return
                }
                
                guard let dailyPlan = dailyPlan as? TRPDailyPlanInfoModel else {
                    XCTFail("\(nameSpace) Json model coundn't converted to  TRPDailyPlanInfoModel")
                    expectation.fulfill()
                    return
                }
                
                completionHandler(dailyPlan, error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 50.0)
    }
}
