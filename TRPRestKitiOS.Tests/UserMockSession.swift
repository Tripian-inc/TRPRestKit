//
//  UserMockSession.swift
//  TRPRestKitiOS.Tests
//
//  Created by Rozeri Dağtekin on 10/28/19.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//
import XCTest
@testable import TRPRestKit
@testable import TRPFoundationKit

/// This class is a -thread safe- singleton class
/// which is used in test classes and gives current user's authetication details.
class UserMockSession: XCTestCase {
    static var shared = UserMockSession()
    private let userName: String = "r@g.com"
    private let password: String = "111111"
    private let apiKey: String = "oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn"
    
    //Saves the user login details that contains the user's access token, token type, email
    func doLogin() {
        
        TRPClient.monitor(data: true, url: true)
        
        guard TRPUserPersistent.didUserLoging() == true else {
            return
        }
        
        let nameSpace = #function
        let expectation = XCTestExpectation(description: "\(nameSpace) expectation")
        
       /* TRPRestKit().login(email: userName, password: password) { (result, error) in
            if error != nil {
                let errorMsg: String = "\(nameSpace) \(error?.localizedDescription ?? "")"
                XCTFail(errorMsg)
                expectation.fulfill()
                fatalError(errorMsg)
            }
            guard result != nil else {
                expectation.fulfill()
                fatalError("result comes nil")
            }
            
            expectation.fulfill()
        } */
        wait(for: [expectation], timeout: 10.0)
    }
}
