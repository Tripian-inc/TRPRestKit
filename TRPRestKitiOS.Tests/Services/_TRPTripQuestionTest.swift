//
//  TRPTripQuestionTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 11.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
import TRPRestKit

class TRPTripQuestionTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn")
    }
    
    func testFethTripQuestionWithCityId() {
        let nameSpace = "TRPTripQuestion"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().tripQuestions(withCityId: 107) { (result, error, pagination) in
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
    
    
    func testFethTripQuestionWithID() {
        let nameSpace = "TRPTripQuestion"
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        TRPRestKit().tripQuestions(withQuestionId: 1) { (result, error) in
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
            
            print("Question \(question)")
            
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 10.0)
    }
}
