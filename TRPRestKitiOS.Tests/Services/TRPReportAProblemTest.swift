//
//  TRPUserInfoUpdate.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 16.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

/// # TRPCitiesTest class which tests cities functions operated by Rest - Kit.

import XCTest
@testable import TRPRestKit

// swiftlint:disable all
class TRPReportAProblemTest: XCTestCase {
    
    // MARK: Variables
    private let fourSeconds: Double = 4.0
    
    // MARK: Set Up
    override func setUp() {
        super.setUp()
    }
    
    // MARK: Report A Problem Tests
    
    /**
     * Tests getProblemCategories with no given parameter.
     */
    func testGetProblemCategories() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().problemCategories {[weak self] (result, error) in
            guard self != nil else {return}
            
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            
            guard let problems = result as? [TRPProblemCategoriesInfoModel]  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            
            XCTAssertNotNil(problems)
            XCTAssertGreaterThan(problems.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    /**
     * Tests report a problem with problem category id, message and placeId parameter.
     */
    func testReportProblem() {
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
        TRPRestKit().reportaProblem(category: TestUtilConstants.MockReportProblem.ProblemCategoryId, message: TestUtilConstants.MockReportProblem.ProblemText, poiId: TestUtilConstants.MockPlaceConstants.PlaceId) {[weak self] (result, error) in
            guard self != nil else { return }
            if let error = error {
                XCTFail("\(nameSpace) Parser Fail: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                XCTFail("\(nameSpace) Result is nil")
                return
            }
            
            guard let problem = result as? TRPReportAProblemInfoModel  else {
                XCTFail("\(nameSpace) Json model coundn't converted to  TRPProgramStep")
                return
            }
            
            XCTAssertNotNil(problem)
            XCTAssertGreaterThan(problem.id, 0)
            XCTAssertEqual(problem.problemCategory, TestUtilConstants.MockReportProblem.ProblemCategoryId)
            XCTAssertEqual(problem.poiId, TestUtilConstants.MockPlaceConstants.PlaceId)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
    }
}

