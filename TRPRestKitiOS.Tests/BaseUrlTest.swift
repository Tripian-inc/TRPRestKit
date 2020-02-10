//
//  BaseUrlTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 16.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class AbBaseUrlTest: XCTestCase {

    func testInitValueEnviroment() {
        TRPClient.start(enviroment: .test, apiKey: "")
        XCTAssertEqual(TRPClient.shared.enviroment, Environment.test)
    }
    
    func testBaseUrlWithEnviroment() {
        TRPClient.start(enviroment: .production, apiKey: "")
        XCTAssertEqual(Environment.production.baseUrl.baseUrl, TRPClient.shared.baseUrl.baseUrl)
    }

    func testBasePathWithEnviroment() {
        TRPClient.start(enviroment: .production, apiKey: "")
        XCTAssertEqual(Environment.production.baseUrl.basePath, TRPClient.shared.baseUrl.basePath)
    }
    
    func testSandBoxWithEnviroment() {
        TRPClient.start(enviroment: .sandbox, apiKey: "")
        XCTAssertEqual(Environment.sandbox.baseUrl.basePath, TRPClient.shared.baseUrl.basePath)
        XCTAssertEqual(Environment.sandbox.baseUrl.baseUrl, TRPClient.shared.baseUrl.baseUrl)
    }
    
    func testTestWithEnviroment() {
        TRPClient.start(enviroment: .test, apiKey: "")
        XCTAssertEqual(Environment.test.baseUrl.basePath, TRPClient.shared.baseUrl.basePath)
        XCTAssertEqual(Environment.test.baseUrl.baseUrl, TRPClient.shared.baseUrl.baseUrl)
    }
    
    func testCustomUrl() {
        let custom = BaseUrlCreater(baseUrl: "a", basePath: "b")
        TRPClient.start(baseUrl: custom, apiKey: "")
        XCTAssertEqual(TRPClient.shared.baseUrl.basePath, custom.basePath)
        XCTAssertEqual(TRPClient.shared.baseUrl.baseUrl, custom.baseUrl)
    }
    
    func testCustomUrlWithNormalStart() {
        TRPClient.start(enviroment: .production, apiKey: "")
        let custom = BaseUrlCreater(baseUrl: "c", basePath: "c")
        TRPClient.start(baseUrl: custom, apiKey: "")
        XCTAssertEqual(TRPClient.shared.baseUrl.basePath, custom.basePath)
        XCTAssertEqual(TRPClient.shared.baseUrl.baseUrl, custom.baseUrl)
    }
    
    func testProductWithStartCustom() {
        let custom = BaseUrlCreater(baseUrl: "c", basePath: "c")
        TRPClient.start(baseUrl: custom, apiKey: "")
        TRPClient.start(enviroment: .production, apiKey: "")
        XCTAssertEqual(Environment.production.baseUrl.basePath, TRPClient.shared.baseUrl.basePath)
    }
 
}
