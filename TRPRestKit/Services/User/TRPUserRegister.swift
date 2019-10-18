//
//  TRPUserRegister.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 11.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPUserRegister: TRPRestServices {

    var password: String?
    var userName: String?
    var email: String?
    
    public init(email: String, password: String) {
        self.password = password
        self.email = email
    }

    public init(userName: String) {
        self.userName = userName
    }

    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.completion?(nil, error, nil)
            return
        }
        guard let data = data else {
            self.completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        let json = String(data: data, encoding: .utf8)
        print("UserJsonResult: \(json!)")
        let jsonDecode = JSONDecoder()
        do {
            if password != nil && email != nil {
                let result = try jsonDecode.decode(TRPUserInfoJsonModel.self, from: data)
                let pag = paginationController(parentJson: result)
                self.completion?(result, nil, pag)
            } else if userName != nil {
                let result = try jsonDecode.decode(TRPTestUserInfoJsonModel.self, from: data)
                let pag = paginationController(parentJson: result)
                self.completion?(result, nil, pag)
            }
            
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }

    public override func parameters() -> [String: Any]? {
        
        if let email = email, let password = password {
            return ["email": email, "password": password]
        }
        if let userName = userName {
            return ["username": userName]
        }
        
        return [:]
    }

    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func requestMode() -> TRPRequestMode {
        return TRPRequestMode.post
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.register.link
    }
}
