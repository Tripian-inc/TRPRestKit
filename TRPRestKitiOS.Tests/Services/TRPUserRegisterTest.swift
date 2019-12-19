//
//  TRPUserRegisterTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 18.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class TRPUserRegisterTest: XCTestCase {

    override func setUp() {
        TRPClient.start(enviroment: .test, apiKey: TestUtilConstants.ApiKeys.Test)
    }
    
    func testRegisterNewUser() {
        TRPRestKit().register(userName: "deneme") { (result, error) in
            
        }
    }

}
