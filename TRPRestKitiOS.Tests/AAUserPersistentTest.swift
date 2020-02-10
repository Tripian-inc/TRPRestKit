//
//  UserPersistentTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 20.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class AaUserPersistentTest: XCTestCase {

    func testHashToken() {
        let hash = "1234"
        TRPUserPersistent.saveHashToken(hash)
        let fetchedHash = TRPUserPersistent.fetchHashToken()
        XCTAssertNotNil(fetchedHash)
        XCTAssertEqual(fetchedHash!, hash)
    }
    
    func testChangeHashToken() {
        let hash = "98765"
        TRPUserPersistent.saveHashToken(hash)
        let fetchedHash = TRPUserPersistent.fetchHashToken()
        XCTAssertNotNil(fetchedHash)
        XCTAssertEqual(fetchedHash!, hash)
    }
    
    func testSaveRemoveHashToken() {
        let hash = "1234567890"
        TRPUserPersistent.saveHashToken(hash)
        TRPUserPersistent.remove()
        let fetchedHash = TRPUserPersistent.fetchHashToken()
        XCTAssertNil(fetchedHash)
    }
    
    func testDidUserLogingFail() {
        let hash = "1234567890"
        TRPUserPersistent.saveHashToken(hash)
        TRPUserPersistent.remove()
        let userStatus = TRPUserPersistent.didUserLoging()
        XCTAssertEqual(userStatus, false)
    }
    
    func testRemoveHashsDidUserLogin() {
        let hash = "1234567890"
        TRPUserPersistent.saveHashToken(hash)
        
        let userStatus = TRPUserPersistent.didUserLoging()
        XCTAssertEqual(userStatus, true)
    }
    
    func testUserLogoutInRestkit() {
        let hash = "1234567890"
        TRPUserPersistent.saveHashToken(hash)
        TRPRestKit().logout()
        let userStatus = TRPUserPersistent.didUserLoging()
        XCTAssertEqual(userStatus, false)
    }
}
