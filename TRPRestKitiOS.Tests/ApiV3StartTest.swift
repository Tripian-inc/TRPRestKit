//
//  ApiV3StartTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 25.02.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class ApiV3StartTest: XCTestCase {
    
    override func setUp() {
        let urlCreater = BaseUrlCreater(baseUrl: "6ezq4jb2mk.execute-api.eu-west-1.amazonaws.com", basePath: "api")
        TRPClient.start(baseUrl: urlCreater, apiKey: "")
        TRPClient.monitor(data: true, url: true)
    }
    
    func testUserRegister() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().register(email: "silV3_19@fakemailxyz.com", password: "123456aA", firstName: "Ali", lastName: "Veli", answers: [1, 2, 3, 4]) { (result, error) in
            XCTAssertNil(error)
            
            if let result = result as? TRPUserInfoModel {
                print("SONUC \(result)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testLogin() {
        //silV3_9@fakemailxyz.com
        //123456aA
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().login(withEmail: "silV3_9@fakemailxyz.com", password: "123456aA") { (result, error) in
            XCTAssertNil(error)
            
            if let result = result as? TRPLoginTokenInfoModel {
                print("SONUC \(result)")
            }else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testRefreshToken() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().login(withEmail: "silV3_9@fakemailxyz.com", password: "123456aA") { (result, error) in
            XCTAssertNil(error)
            
            if let result = result as? TRPLoginTokenInfoModel {
                
                TRPRestKit().refreshToken(result.refresthToken) { (result, error) in
                    XCTAssertNil(error)
                    if  result is TRPRefreshTokenInfoModel {
                        expectation.fulfill()
                        return
                    }
                    XCTFail()
                }
                return
            }
            XCTFail()
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testRefreshTokenBasic() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().login(withEmail: "silV3_9@fakemailxyz.com", password: "123456aA") { (result, error) in
            XCTAssertNil(error)
            
            if let result = result as? TRPLoginTokenInfoModel {
                
                TRPRestKit().refreshToken(result.refresthToken) { (result, error) in
                    XCTAssertNil(error)
                    if  result is TRPRefreshTokenInfoModel {
                        expectation.fulfill()
                    }else {
                        XCTFail()
                    }
                }
                return
            }
            XCTFail()
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testUserTrip() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().userTrips { (result, error, pag) in
            XCTAssertNil(error)
            if let result = result as? [TRPUserTripInfoModel] {
                print("RRRR \(result.count)")
                expectation.fulfill()
                return
                
            }
            XCTFail()
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testCreateTrip() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        let arrival = getDaysAfter(withDays: 10)
        let departure = getDaysAfter(withDays: 12)
        let settings = TRPTripSettings(cityId: 107, arrivalTime: arrival, departureTime: departure)
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
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUserFavorite() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().login(withEmail: "silV3_19@fakemailxyz.com", password: "123456aA") { (result, error) in
            XCTAssertNil(error)
            
            if let result = result as? TRPLoginTokenInfoModel {
                TRPRestKit().getUserFavorite(cityId: 107) { (result, error) in
                    XCTAssertNil(error)
                    expectation.fulfill()
                }
            }else {
                XCTFail()
                return
            }
            
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testGetTripWithParams() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
       /* TRPRestKit().userTrips { (result, error, _) in
            XCTAssertNil(error)
            
            if let result = result as? [TRPUserTripInfoModel] {
                
                TRPRestKit().getTrip(withHash: result.first!.tripHash) { (resut, error) in
                    XCTAssertNil(error)
                    if let result = resut as? TRPTripModel {
                        print(result.plans)
                        expectation.fulfill()
                    }
                }
                
                return
            }
        }*/
        TRPRestKit().getTrip(withHash: "2f75f97d2b094920966ef3d705abbe74") { (resut, error) in
            XCTAssertNil(error)
            if let result = resut as? TRPTripModel {
                print(result.plans)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
}
