//
//  GenericParserTest.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 28.02.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class TRPGenericParserTest: XCTestCase {
    
    
    private let registerRawValue = """
{
    "status": 200,
    "success": true,
    "message": "Success",
    "data": {
        "username": "28a3f614-3f4d-4029-bb30-f2cd275adfb9",
        "email": "silV3_10@fakemailxyz.com",
        "first_name": "Ali",
        "last_name": "Veli",
        "profile": {
            "answers": [1, 2, 3, 4],
            "age": null
        }
    }
}
"""
    private let emtyArray = """
    {
        "status": 200,
        "success": true,
        "message": "Success",
        "data": []
    }
    """
    
    private let basicArray = """
    {
        "status": 200,
        "success": true,
        "message": "Success",
        "data": [1,2,3]
    }
    """
    private let emptyArray = """
    {
        "status": 200,
        "success": true,
        "message": "Success",
        "data": []
    }
    """
    
    private let basicObjectArray = """
    {
        "status": 200,
        "success": true,
        "message": "Success",
        "data": [{"id":1}]
    }
    """
    
    private var jsonDecoder: JSONDecoder?
    
    override func setUp() {
        super.setUp()
        jsonDecoder = JSONDecoder()
    }
    
    /// Obje parse edip edemediğini test eder
    func testObjectParse() {
        do {
            let result  = try JsonParser.parse(TRPGenericParser<TRPUserInfoModel>.self, rawData: registerRawValue)
            XCTAssertEqual(result.data!.email, "silV3_10@fakemailxyz.com")
            XCTAssertNotNil(result.data!.firstName)
            XCTAssertNotNil(result.data!.lastName)
        } catch let tryError {
            XCTFail(tryError.localizedDescription)
        }
    }
    
    func testEmptyArrayParser() {
        do {
            
            let result  = try JSONDecoder().decode(TRPGenericParser<[Int]>.self, from: emtyArray.data(using: String.Encoding.utf8)!)
            XCTAssertEqual(result.data!.count, 0)
        } catch let tryError {
            XCTFail(tryError.localizedDescription)
        }
    }
    
    func testIntArrayParser() {
        do {
            
            let result  = try JSONDecoder().decode(TRPGenericParser<[Int]>.self, from: basicArray.data(using: String.Encoding.utf8)!)
            XCTAssertEqual(result.data!.count, 3)
        } catch let tryError {
            XCTFail(tryError.localizedDescription)
        }
    }
    
    func testCityEmptyArrayParser() {
        do {
            
            let result  = try JSONDecoder().decode(TRPGenericParser<[TRPCityInfoModel]>.self, from: emtyArray.data(using: String.Encoding.utf8)!)
            XCTAssertEqual(result.data!.count, 0)
        } catch let tryError {
            XCTFail(tryError.localizedDescription)
        }
    }
    
    func testCityArrayParser() {
        do {
            
            let result  = try JSONDecoder().decode(TRPGenericParser<[BasicDataModel]>.self, from: basicObjectArray.data(using: String.Encoding.utf8)!)
            
            XCTAssertNotNil(result.data)
            XCTAssertEqual(result.data!.count, 1)
            XCTAssertEqual(result.data!.first!.id, 1)
        } catch let tryError {
            XCTFail(tryError.localizedDescription)
        }
    }
}

public class BasicDataModel: Decodable {
    var id: Int?
}
