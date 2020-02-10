//
//  MockLogin.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 11.10.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPRestKit

class MockLogin {
    
    static func testUserLogin( copleted: @escaping (Bool) -> Void) {
        
        TRPRestKit().login(email: "necatievren@gmail.com", password: "123456") { (result, error) in
            if error == != nil {
                copleted(false)
                return
            }
            
            guard let result = result else {
                copleted(true)
                return
            }
        }
    }
    
}
