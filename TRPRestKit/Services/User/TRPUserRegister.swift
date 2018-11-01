//
//  TRPUserRegister.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 11.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPUserRegister: TRPRestServices{

    var password: String?

    /// Create New User
    ///
    /// - Parameters:
    ///   - firstName: User Name
    ///   - lastName: User Last Name
    ///   - email: User email adress
    ///   - password: user password
    public init(password: String) {
        self.password = password
    }


    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.Completion?(nil,error, nil);
            return
        }
        guard let data = data else {
            self.Completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        let json = String(data: data, encoding: .utf8)
        print("UserJsonResult: \(json!)");
        let jsonDecode = JSONDecoder();
        do {
            let result = try jsonDecode.decode(TRPUserInfoJsonModel.self, from: data)
            let pag = paginationController(parentJson: result)
            self.Completion?(result, nil, pag);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }

    public override func parameters() -> Dictionary<String, Any>? {
        var params: [String:Any] = [:]
        params["password"] = password ?? ""
        return params
    }

    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func requestMode() -> TRPRequestMode {
        return TRPRequestMode.post
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.Register.link;
    }
}
