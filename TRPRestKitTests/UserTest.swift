 //
//  UserTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 27.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class UserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("c2db92dbf179338c691503f1788b3447")
    }
    
    
    func testEmptyUserHash() {
        TRPUserPersistent.remove()
        let hash = TRPUserPersistent.fetchHash()
        if hash != nil {
            XCTFail("User hash isn't nil")
        }
    }
    
   

    
}
