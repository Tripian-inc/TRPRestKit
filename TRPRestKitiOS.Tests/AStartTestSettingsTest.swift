//
//  AStartTestSettingsTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 19.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class AStartTestSettingsTest: XCTestCase {

    var url = "gogole.com"
    var path = "v2"
    
    func testPrepareSystem() {
        TRPRestKit().logout()
        TestUtilConstants.targetServer = .airMiles
        UserMockSession.shared.doLogin()
    }
    
}
