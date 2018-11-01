//
//  TRPParentJsonModelTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 24.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit

class TRPParentJsonModelTest: XCTestCase {
    var jsonDecoder: JSONDecoder?;
    
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
            
        }catch(let tryError) {
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
            
        }catch(let tryError) {
            XCTFail(tryError.localizedDescription)
        }
    }
    
    
    
    func testWithoutData() {
        let rawJson = """
    {
        "status": 200,
        "success": true,
        "pagination": {
            "count": 1,
            "total": 3,
            "perPage": 1,
            "currentPage": 1,
            "totalPages": 3,
            "links": {
            }
        }
    }
    """
        do {
            let result = try jsonDecoder!.decode(TRPParentJsonModel.self, from: rawJson.data(using: String.Encoding.utf8)!)
            print(result)
        }catch(let tryError) {
            XCTFail(tryError.localizedDescription)
        }
    }
    
    
    func testEmptyData() {
        let rawJson = """
    {
        "status": 200,
        "success": true,
        "data": [],
        "pagination": {
            "count": 1,
            "total": 3,
            "perPage": 1,
            "currentPage": 1,
            "totalPages": 3,
            "links": {
            }
        }
    }
    """
        do {
            let result = try jsonDecoder!.decode(TRPParentJsonModel.self, from: rawJson.data(using: String.Encoding.utf8)!)
            print(result)
        }catch(let tryError) {
            XCTFail(tryError.localizedDescription)
        }
    }
    
}
