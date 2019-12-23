//
//  UserMockSession.swift
//  TRPRestKitiOS.Tests
//
//  Created by Rozeri Dağtekin on 10/28/19.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//
import XCTest
@testable import TRPRestKit
import TRPFoundationKit

/// This class is a -thread safe- singleton class
/// which is used in test classes and gives current user's authetication details.
class UserMockSession: XCTestCase {
    static var shared = UserMockSession()
    
    func setServer() {
        switch TestUtilConstants.targetServer {
        case .airMiles:
            TRPClient.start(baseUrl: TestUtilConstants.Server.airMiles.url, apiKey: TestUtilConstants.targetServer.apiKey)
        case .product:
            TRPClient.start(enviroment: .production, apiKey: TestUtilConstants.targetServer.apiKey)
        case .sandBox:
            TRPClient.start(enviroment: .sandbox, apiKey: TestUtilConstants.targetServer.apiKey)
        case .test:
            TRPClient.start(enviroment: .test, apiKey: TestUtilConstants.targetServer.apiKey)
        }
        TRPClient.monitor(data: true, url: true)
    }

    //Saves the user login details that contains the user's access token, token type, email
    func doLogin() {
        
        guard TRPUserPersistent.didUserLoging() == false else {
            return
        }
        
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        if TestUtilConstants.targetServer == .airMiles {
            let params = ["email": TestUtilConstants.MockUserConstants.Email,
                          "password": TestUtilConstants.MockUserConstants.Password]
            TRPRestKit().login(with: params) { (result, error) in
                if error != nil {
                    let errorMsg: String = "\(nameSpace) \(error?.localizedDescription ?? "")"
                    XCTFail(errorMsg)
                    expectation.fulfill()
                    fatalError(errorMsg)
                }
                guard result != nil else {
                    expectation.fulfill()
                    fatalError("result comes nil")
                }
                expectation.fulfill()
            }
        }else {
            TRPRestKit().login(withUserName: TestUtilConstants.MockUserConstants.TestUserName) { (result, error) in
                XCTAssertNil(error, "\(error!.localizedDescription)")
                XCTAssertNotNil(result, "Result is nil")
                guard let result = result as? TRPLoginInfoModel else {
                    expectation.fulfill()
                    return
                }
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.accessToken)
                XCTAssertNotNil(result.tokenType)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
