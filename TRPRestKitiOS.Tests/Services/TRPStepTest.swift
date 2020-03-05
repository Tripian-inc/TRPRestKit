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
    
    override func setUp() {
        UserMockSession.shared.setServer()
        UserMockSession.shared.doLogin()
    }
    
    //Add Step
    
    // Edit Step
    
    // Delete Step
    
    
    func testV1() {
        let expectation = XCTestExpectation(description:"a")
        print("V1")
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 9) {
            print("V1 Completed")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testV2() {
        let expectation = XCTestExpectation(description:"a")
        print("V2")
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            print("V2 Completed")
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testV3() {
        let expectation = XCTestExpectation(description:"a")
        print("V3")
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            print("V3 Completed")
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    
    
    func myFunction() {
        var a: Int?

        let group = DispatchGroup()
        group.enter()

        
        
        DispatchQueue.main.async {
            a = 1
            group.leave()
        }

        // does not wait. But the code in notify() gets run
        // after enter() and leave() calls are balanced

        group.notify(queue: .main) {
            print(a)
        }
    }
    
}
