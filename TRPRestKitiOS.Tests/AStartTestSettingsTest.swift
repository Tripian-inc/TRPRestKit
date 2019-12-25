//
//  AStartTestSettingsTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 19.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class BaAdStartTestSettingsTest: XCTestCase {

    override func setUp() {
        TRPRestKit().logout()
    }
    
    override func tearDown() {
        UserMockSession.shared.setServer()
        UserMockSession.shared.doLogin()
    }
    func testPrepareSystem() {
        
        TestUtilConstants.targetServer = .test
        TRPClient.monitor(data: true, url: true)
        UserMockSession.shared.setServer()
        UserMockSession.shared.doLogin()
    }
    
}
