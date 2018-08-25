//
//  TRPOauthServicesTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 24.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class TRPOauthServicesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("c2db92dbf179338c691503f1788b3447")
    }
    
    func testOaut() {
        let expression = XCTestExpectation(description: "Test Oaut Expectation")
        
        let oauth = TRPOauthServices(userName: "test@tripian.com", password: "pass")
        oauth.Completion = {(result, error, pagination) in
            print("ROCK ROCK ROKC")
            expression.fulfill()
        }
        oauth.connection()
        
        wait(for: [expression], timeout: 5.0)
    }
    
}
