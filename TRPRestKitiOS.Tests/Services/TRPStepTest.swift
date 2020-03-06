//
//  TRPStepTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 5.03.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

// swiftlint:disable all
class TRPStepTest: XCTestCase {
    
    private var createdNewModel: TRPTripModel!
    
    override func setUp() {
        UserMockSession.shared.setServer()
        UserMockSession.shared.doLogin()
        do {
           createdNewModel = try CreateTripHelper().create()
        }catch {
            print("[Error] \(error.localizedDescription)")
            fatalError(error.localizedDescription)
        }
    }

    func testK() {
        print("TRİP INFOSU \(createdNewModel.city.name)")
        XCTAssert(true)
    }
    
    
    //Add Step
    
    
    // Edit Step
    
    // Delete Step
    
    
    
    
}
