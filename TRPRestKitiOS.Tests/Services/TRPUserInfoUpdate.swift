//
//  TRPUserInfoUpdate.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 16.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class AfTRPUserInfoUpdate: XCTestCase {
    
    override func setUp() {
        super.setUp()
        UserMockSession.shared.setServer()
        UserMockSession.shared.doLogin()
    }
    
    override func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
    
    func testUserInfoUpdate() {
        let nameSpace = "TRPUserLogin"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        let randomName = randomString(length: 5)
        let randomLastName = randomString(length: 7)
        let randomAge = Int.random(in: 22..<40)
        
        TRPRestKit().updateUserInfo(firstName: randomName, lastName: randomLastName, age: randomAge) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                expectation.fulfill()
                return
            }
            guard let model = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                expectation.fulfill()
                return
            }
            
            if TestUtilConstants.targetServer == .airMiles {
                XCTAssertNotNil(model.lastName)
                XCTAssertNotNil(model.firstName)
                XCTAssertEqual(model.lastName!, randomLastName)
                XCTAssertEqual(model.firstName!, randomName)
            }else {
                XCTAssert(!model.username.isEmpty)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateUserName() {
        let nameSpace = "TRPUserLogin"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        let randomName = randomString(length: 5)
        
        TRPRestKit().updateUserInfo(firstName: randomName) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                expectation.fulfill()
                return
            }
            guard let model = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(model.firstName)
            XCTAssertEqual(model.firstName!, randomName)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateUserLastName() {
        let nameSpace = "TRPUserLogin"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        let randomName = randomString(length: 5)
        
        TRPRestKit().updateUserInfo(lastName: randomName) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                expectation.fulfill()
                return
            }
            guard let model = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(model.lastName)
            XCTAssertEqual(model.lastName!, randomName)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateUserAge() {
        let nameSpace = "TRPUserLogin"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        let randomAge = Int.random(in: 1..<99)
        TRPRestKit().updateUserInfo(age: randomAge) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                expectation.fulfill()
                return
            }
            guard let model = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(model.profile)
            XCTAssertNotNil(model.profile!.age)
            XCTAssertEqual(model.profile!.age!, randomAge)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateAnswerEmtyArrayUserAge() {
        let nameSpace = "TRPUserLogin"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().updateUserAnswer(answers: []) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                expectation.fulfill()
                return
            }
            guard let model = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(model.profile)
            XCTAssertEqual(model.profile!.answers.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateUserAnswers() {
        let nameSpace = "TRPUserLogin"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        let answers: [Int] = [Int.random(in: 1..<99), Int.random(in: 1..<99), Int.random(in: 1..<99)]
        
        TRPRestKit().updateUserAnswer(answers: answers) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                expectation.fulfill()
                return
            }
            guard let model = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(model.profile)
            XCTAssertEqual(model.profile!.answers.count, answers.count)
            XCTAssertEqual(model.profile!.answers, answers)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateUserAnswersAndAge() {
        let nameSpace = "TRPUserLogin"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        let answers: [Int] = [Int.random(in: 1..<99), Int.random(in: 1..<99), Int.random(in: 1..<99)]
        let randomAge = Int.random(in: 1..<99)
         
        TRPRestKit().updateUserInfo(age: randomAge, answers: answers) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                expectation.fulfill()
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                expectation.fulfill()
                return
            }
            guard let model = result as? TRPUserInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(model.profile)
            XCTAssertEqual(model.profile!.answers.count, answers.count)
            XCTAssertEqual(model.profile!.answers, answers)
            XCTAssertNotNil(model.profile!.age)
            XCTAssertEqual(model.profile!.age!, randomAge)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
