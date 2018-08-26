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
       
        let userName = "necatievren@gmail.com"
        let password = "123456"
        let oauth = TRPOAuth(userName: userName, password: password)
        oauth.Completion = {(result, error, pagination) in
            
            if let error = error {
                XCTFail("TRPOAuth Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("TRPOAuth Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPOAuthJsonModel else {
                XCTFail("TRPOAuth Json model coundn't converted to  TRPOAuthJsonModel")
                return
            }
            
            print("")
            print("ACCESS TOKEN")
            print(jsonModel.data.accessToken)
            print("")
            expression.fulfill()
        }
        oauth.connection()
        
        wait(for: [expression], timeout: 15.0)
    }
    
    
    
}
