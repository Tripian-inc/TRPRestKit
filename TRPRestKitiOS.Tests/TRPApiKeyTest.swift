//
//  TRPApiKeyTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 16.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class AgTRPApiKeyTest: XCTestCase {
    
    func testSetApiKey() {
        let apiKey = "oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn"
        TRPApiKey.setApiKey(apiKey)
        let sonuc = TRPApiKey.getApiKey()
        XCTAssertEqual(sonuc, apiKey)
    }
    
    /// You can see Error message on Console.
    func testSetEmptyApiKeyWithInit() {
        let apiKey = ""
        TRPClient.start(enviroment: .test, apiKey: apiKey)
        let result = TRPApiKey.getApiKey()
        XCTAssertEqual(result, apiKey)
    }
    
    func testSetSmallApiKeyWithInitForTest() {
        let apiKey = "123"
        TRPClient.start(enviroment: .test, apiKey: apiKey)
        let result = TRPApiKey.getApiKey()
        XCTAssertEqual(result, apiKey)
    }
 
    func testSetSmallApiKeyWithInitForCustomLink() {
        let apiKey = "123"
        TRPClient.start(baseUrl: BaseUrlCreater(baseUrl: "a", basePath: "b"), apiKey: apiKey)
        let result = TRPApiKey.getApiKey()
        XCTAssertEqual(result, apiKey)
    }
    
}
