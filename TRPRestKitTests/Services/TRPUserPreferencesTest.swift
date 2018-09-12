//
//  TRPUserPreferencesTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 11.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
import TRPRestKit

class TRPUserPreferencesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    
    func testGetUserPreferences() {
        let nameSpace = "TRPUserRegister"

        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().userPreferences { (result, error, pagination) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let _ = result as? [TRPUserPreferencesInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPUserPreferencesInfoModel")
                return
            }
            
          
            expectation.fulfill()
        }
       
        wait(for: [expectation], timeout: 10.0)
    }
    
    
}
