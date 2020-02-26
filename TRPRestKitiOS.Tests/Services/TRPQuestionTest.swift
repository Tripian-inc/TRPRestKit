//
//  TRPQuestionTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 14.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// # TRPCitiesTest class tests trip and profile question functions operated by Rest - Kit.

import XCTest
@testable import TRPRestKit
class TRPQuestionTest: XCTestCase {
    
    // MARK: Variables
    private let questionId = TestUtilConstants.MockQuestionConstants.QuestionId
    private let cityId = TestUtilConstants.MockCityConstants.IstanbulCityId
    
    // MARK: Set Up
    override func setUp() {
        super.setUp()
        let urlCreater = BaseUrlCreater(baseUrl: "6ezq4jb2mk.execute-api.eu-west-1.amazonaws.com", basePath: "api")
         TRPClient.start(baseUrl: urlCreater, apiKey: "")
         TRPClient.monitor(data: true, url: true)
    }
    
    // MARK: Test Functions
    
    /**
     * Tests Trip Question with given cityId.
     */
    func testTripQuestionsWithCityId() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().questions(withCityId: cityId) { (result, error, _) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            guard let question = result as? [TRPQuestionInfoModel]  else {
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
    
    /**
     * Tests Trip Questions with
     * type -> "trip",
     * and thus response should give the standard trip questions.
     */
    func testTripQuestions() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().questions(type: .trip) { (result, error, _) in
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
            
            guard let question = result as? [TRPQuestionInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                expectation.fulfill()
                return
            }
            if question.count < 1 {
                XCTFail("\(nameSpace) no exist data in array")
            }
            
            
            XCTAssertNotNil(question.first!.id)
            XCTAssertNotNil(question.first!.name)
            XCTAssertNotNil(question.first!.options)
            XCTAssertEqual(question.first!.category, .trip)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * Tests Profile Questions with
     * type -> "profile",
     * and thus response should give the standard trip questions.
     */
    func testProfileQuestions() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().questions(type: .profile) { (result, error, _) in
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("\(nameSpace) Resutl is nil")
                return
            }
            
            guard let question = result as? [TRPQuestionInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPTripQuestionInfoModel")
                return
            }
            if question.count < 1 {
                XCTFail("\(nameSpace) no exist data in array")
            }
            XCTAssertNotNil(question.first!.id)
            XCTAssertNotNil(question.first!.name)
            XCTAssertNotNil(question.first!.options)
            XCTAssertEqual(question.first!.category, .profile)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
