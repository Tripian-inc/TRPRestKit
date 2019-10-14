//
//  TRPPoiTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 14.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class TRPPoiTest: XCTestCase{
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
        TRPClient.printData(true)
    }
    
    func testPoiWithId() {}
    
    func testPoiWithIdsWithCity() {}
    
    func testPoiWithCityId() {}
    
    func testPoiWithLink() {}
    
    func testPoiWithLocation() {}
    
    func testPoiWithCategory() {}
    
    func testPoiWithLocationDistance() {}
    
    func testPoiWithLocationCategory() {}
    
    
}
