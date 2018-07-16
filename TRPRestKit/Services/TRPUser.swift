//
//  TRPUser.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 9.07.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPUser: TRPRestServices{
    
    let email: String
    let password: String
    
    public init(email: String, password: String) {
        self.email = email
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
            let result = try jsonDecode.decode(TRPCityJsonModel.self, from: data)
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    
    public override func parameters() -> Dictionary<String, Any>? {
        var params: [String:Any] = [:]
        params["email"] = email
        params["password"] = password
        return params
    }
    
    public override func path() -> String {
        let path = TRPConfig.ApiCall.User.link;
        return path;
    }
    
    public override func requestMode() -> TRPRequestMode {
        return TRPRequestMode.post
    }
}
