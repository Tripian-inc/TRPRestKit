//
//  TRPPlaceTypeJsonModelTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 24.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit


class TRPPlaceTypeJsonModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("c2db92dbf179338c691503f1788b3447")
    }
    
    func testA() {
        XCTAssertEqual(1, 1)
    }
    
//    func testTypeApi() {
//        let expection = XCTestExpectation(description: "Type Api Expectation")
//        TRPRestKit().types { (result, error) in
//            if let error = error {
//                XCTFail(error.localizedDescription)
//                return
//            }
//
//            guard let jsonModel = result as? TRPTypeJsonModel else {
//                XCTFail("Type Json Model Convert Error.")
//                return
//            }
//
//            guard let data = jsonModel.data else {
//                XCTFail("Type Info Model Convert Error.")
//                return
//            }
//
//            print("IDMM \(data.first?.id)")
//
//            expection.fulfill()
//        }
//
//        wait(for: [expection], timeout: 5.0)
//    }
   
    
    
    
    
    
}
