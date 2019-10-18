//
//  TRPQuestionTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 14.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class TRPQuestionTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
        
    }
    
    func testTripQuestionsWithQuestionId() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        let questionID = 1
        TRPRestKit().tripQuestions(withQuestionId: questionID) { (result, error) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let question = result as? TRPTripQuestionInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                return
            }
            XCTAssertNotNil(question.id)
            XCTAssertNotNil(question.name)
            XCTAssertNotNil(question.options)
            XCTAssertEqual(question.id, questionID)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testTripQuestionsWithCityId() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().tripQuestions(withCityId: 107) { (result, error, _) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let question = result as? [TRPTripQuestionInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                return
            }
            if question.count < 1 {
                XCTFail("\(nameSpace) no exist data in array")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testTripQuestionsType() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().tripQuestions(type: TPRTripQuestionType.profile) { (result, error, _) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            
            guard let question = result as? [TRPTripQuestionInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                return
            }
            if question.count < 1 {
                XCTFail("\(nameSpace) no exist data in array")
            }
            XCTAssertNotNil(question.first!.id)
            XCTAssertNotNil(question.first!.name)
            XCTAssertNotNil(question.first!.options)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
