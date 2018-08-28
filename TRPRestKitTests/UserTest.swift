 //
//  UserTest.swift
//  TRPRestKitTests
//
//  Created by Evren Yaşar on 27.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPRestKit
class UserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TRPClient.provideApiKey("c2db92dbf179338c691503f1788b3447")
    }
    
    
//    func testEmptyUserHash() {
//        TRPUserPersistent.remove()
//        let hash = TRPUserPersistent.fetchHash()
//        if hash != nil {
//            XCTFail("User hash isn't nil")
//        }
//    }
    
    func testLoginUser() {
        let expectation = XCTestExpectation(description: "TRPRestKit.userLogin expectation")
        let mail = "necatievren@gmail.com"
        let password = "123456"
        TRPRestKit().userLogin(email: mail, password: password) { (result, error) in
            if let error = error {
                XCTFail("UserLogin Parser Fail: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                XCTFail("UserLogin Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPOAuthJsonModel else {
                XCTFail("UserLogin Json model coundn't converted to  TRPOAuthJsonModel")
                return
            }
            
            guard let userHash = TRPUserPersistent.fetchHash() else{
                XCTFail("UserLogin Hash coundn't save")
                return
            }
            
            XCTAssertEqual(userHash, jsonModel.data.accessToken,"User hash not equel user token")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    func testUserInfo() {
        let expectation = XCTestExpectation(description: "TRPRestKit.cities expectation")
       
        TRPRestKit().getUserInfo { (result, error) in
            if let error = error {
                XCTFail("UserMe Parser Fail: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                XCTFail("UserMe Resutl is nil")
                return
            }
            
            guard let jsonModel = result as? TRPUserMeJsonModel else {
                XCTFail("UserMe Json model coundn't converted to  TRPOAuthJsonModel")
                return
            }
            
            print("User Name: \(jsonModel.data.email)")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
}
