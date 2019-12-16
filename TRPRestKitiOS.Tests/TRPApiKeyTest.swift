//
//  TRPApiKeyTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 16.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class TRPApiKeyTest: XCTestCase {

    func testEmptyApiKey() {
        let key = TRPApiKey.shared.apiKey
        XCTAssertNil(key)
    }

    func testFetchApiKey() {
        self.measure {
            let sonuc = TRPApiKey.getApiKey()
            XCTAssertEqual(sonuc, "")
        }
    }
    
    func testSetApiKey() {
        let apiKey = "oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn"
        TRPApiKey.setApiKey(apiKey)
        let sonuc = TRPApiKey.getApiKey()
        XCTAssertEqual(sonuc, apiKey)
    }
    
}
