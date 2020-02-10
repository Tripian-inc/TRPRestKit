//
//  TRPCompanion.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 16.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// # TRPCompanionTest class which tests companion functions operated by Rest - Kit.

import XCTest
@testable import TRPRestKit
import TRPFoundationKit

// swiftlint:disable all
class TRPCompanionTest: XCTestCase {
    
    // MARK: Set Up
    override func setUp() {
        super.setUp()
    }
    
    // MARK: - Test Functions
    
    /**
     * Test Get Companions with no parameter given.
     */
    func testGetCompanions() {
        
        let nameSpace = #function
        let expectation = XCTestExpectation(description: name)
        
        TRPRestKit().getUsersCompanions { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                expectation.fulfill()
                return
            }
            guard let models = result as? [TRPCompanionModel]  else {
                XCTFail("\(nameSpace) Json model couldn't converted")
                
                expectation.fulfill()
                return
            }
            
            XCTAssertGreaterThan(models.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    /**
     * Tests addCompanion With given Companion info, and thus
     * checks getUserCompanion response have the added companion.
     */
    func testAddCompanion() {
        
        let nameSpace = #function
        let expectation = XCTestExpectation(description: name)
        let randomName = randomString(length: 7)
        let randomAge = Int.random(in: 20..<80)
        let answers = [42, 43]
        
        TRPRestKit().addCompanion(name: randomName, age: randomAge, answers: answers) { [weak self] (result, error) in
            guard self != nil else {return}
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(result)
            
            TRPRestKit().getUsersCompanions { (result, error) in
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    expectation.fulfill()
                    return
                }
                guard let result = result else {
                    XCTFail("\(nameSpace) Result is nil")
                    expectation.fulfill()
                    return
                }
                guard let models = result as? [TRPCompanionModel]  else {
                    XCTFail("\(nameSpace) Json model couldn't converted")
                    expectation.fulfill()
                    return
                }
                
                let addedCompanion = models.filter { $0.name == randomName }.first
                XCTAssertEqual(addedCompanion?.name, randomName)
                XCTAssertEqual(addedCompanion?.age, randomAge)
                XCTAssertGreaterThan(models.count, 0)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 20)
    }
    
    /**
     * Tests updateCompanion by getting first Companion of the user,
     * then changes companion's information, then checks again with getting the same companion by using it's id.
     */
    func testUpdateCompanion() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: name)
        
        TRPRestKit().getUsersCompanions { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                expectation.fulfill()
                return
            }
            guard let models = result as? [TRPCompanionModel]  else {
                XCTFail("\(nameSpace) Json model couldn't converted")
                expectation.fulfill()
                return
            }
            
            if models.count == 0 {
                expectation.fulfill()
                expectation.fulfill()
                return
            }

            let firstCompanion = models.first
            let randomName = self.randomString(length: 7)
            let randomAge = Int.random(in: 20..<80)
            let mockAnswers = [44]
            
            TRPRestKit().updateCompanion(id: (firstCompanion?.id)!, name: randomName, age: randomAge, answers: mockAnswers) {[weak self] (result, error) in
                guard self != nil else {return}
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    expectation.fulfill()
                    return
                }
                guard let result = result else {
                    XCTFail("\(nameSpace) Result is nil")
                    expectation.fulfill()
                    return
                }
                guard result is TRPParentJsonModel  else {
                    XCTFail("\(nameSpace) Json model couldn't converted")
                    expectation.fulfill()
                    return
                }
                
                XCTAssertEqual((result as! TRPParentJsonModel).status,  200)
                
                TRPRestKit().getUsersCompanions { (result, error) in
                    if let error = error {
                        XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                        expectation.fulfill()
                        return
                    }
                    guard let result = result else {
                        XCTFail("\(nameSpace) Result is nil")
                        expectation.fulfill()
                        return
                    }
                    guard let models = result as? [TRPCompanionModel]  else {
                        XCTFail("\(nameSpace) Json model couldn't converted")
                        expectation.fulfill()
                        return
                    }
                    let updatedCompanion = models.filter { $0.id == firstCompanion?.id }.first
                    XCTAssertEqual(updatedCompanion!.name, randomName)
                    XCTAssertEqual(updatedCompanion!.age, randomAge)
                    XCTAssertEqual(updatedCompanion!.answers, self!.toString(array: mockAnswers))
                    expectation.fulfill()
                }
            }
            
        }
        
        wait(for: [expectation], timeout: 40)
    }
    
    /**
     * Tests removeCompanion by getting user's first companion
     * then calls, removeCompanion function,
     * then gets companion list of user,
     * checks whether user has that companion and returns.
     */
    func testRemoveCompanion() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: name)
        
        TRPRestKit().getUsersCompanions { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                expectation.fulfill()
                return
            }
            guard let models = result as? [TRPCompanionModel]  else {
                XCTFail("\(nameSpace) Json model couldn't converted")
                expectation.fulfill()
                return
            }
            
            XCTAssertGreaterThan(models.count, 0)
            let firstCompanion = models.first
            
            TRPRestKit().removeCompanion(companionId: (firstCompanion?.id)!) {[weak self] (result, error) in
                guard self != nil else {return}
                if let error = error {
                    XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                    expectation.fulfill()
                    return
                }
                guard let result = result else {
                    XCTFail("\(nameSpace) Result is nil")
                    expectation.fulfill()
                    return
                }
                guard result is TRPParentJsonModel  else {
                    XCTFail("\(nameSpace) Json model couldn't converted")
                    expectation.fulfill()
                    return
                }
                
                XCTAssertEqual((result as! TRPParentJsonModel).status,  200)
                
                TRPRestKit().getUsersCompanions { (result, error) in
                    if let error = error {
                        XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                        expectation.fulfill()
                        return
                    }
                    guard let result = result else {
                        XCTFail("\(nameSpace) Result is nil")
                        expectation.fulfill()
                        return
                    }
                    guard let models = result as? [TRPCompanionModel]  else {
                        XCTFail("\(nameSpace) Json model couldn't converted")
                        expectation.fulfill()
                        return
                    }
                    let deletedCompanion = models.filter { $0.id == firstCompanion?.id }.first
                    XCTAssertNil(deletedCompanion)
                    expectation.fulfill()
                }
            }
            
        }
        
        wait(for: [expectation], timeout: 20)
    }
}
