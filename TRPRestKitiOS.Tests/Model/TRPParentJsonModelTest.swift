//
//  TRPParentJsonModelTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 11.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class TRPParentJsonModelTest: XCTestCase {
    var jsonDecoder: JSONDecoder?
    
    override func setUp() {
        super.setUp()
        jsonDecoder = JSONDecoder()
    }
    
    func testSuccessAndStatus() {
        let rawJson = """
        {
            "status": 200,
            "success": true,
        }
        """
        do {
            let result = try jsonDecoder!.decode(TRPParentJsonModel.self, from: rawJson.data(using: String.Encoding.utf8)!)
            XCTAssertEqual(result.status, 200, "Status not equeal 200")
            XCTAssertEqual(result.success, true, "Status isn't true")
            
        } catch let tryError {
            XCTFail(tryError.localizedDescription)
        }
    }
    
    func testSuccessStatusMessage() {
        let rawJson = """
        {
            "status": 200,
            "success": true,
            "message": "Success"
        }
    """
        do {
            let result = try jsonDecoder!.decode(TRPParentJsonModel.self, from: rawJson.data(using: String.Encoding.utf8)!)
            XCTAssertTrue(result.success, "Status isn't true")
            XCTAssertNil(result.pagination)
        } catch let tryError {
            XCTFail(tryError.localizedDescription)
        }
    }
    
    func testWithoutDataAndPagination() {
        let rawJson = """
    {
        "status": 200,
        "success": true,
        "pagination": {
            "count": 1,
            "total": 3,
            "per_page": 1,
            "current_page": 1,
            "total_pages": 3,
            "links": {
            }
        }
    }
    """
        do {
            let result = try jsonDecoder!.decode(TRPParentJsonModel.self, from: rawJson.data(using: String.Encoding.utf8)!)
            XCTAssertEqual(result.status, 200)
            XCTAssertEqual(result.success, true)
            XCTAssertNotNil(result.pagination)
            XCTAssertNotEqual(result.pagination?.count, 0)
            XCTAssertNotEqual(result.pagination?.total, 0)
            XCTAssertNotEqual(result.pagination?.currentPage, 0)
            XCTAssertEqual(result.pagination?.currentPage, 1)
            
        } catch let tryError {
            XCTFail(tryError.localizedDescription)
        }
    }
    
}
