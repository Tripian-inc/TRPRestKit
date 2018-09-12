//
//  TRPOauthServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 24.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

public class TRPLogin: TRPRestServices{
    
    private var email: String
    private var password: String
    
    public init(email: String, password: String){
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
        
        let jsonDecode = JSONDecoder();
        do {
            let result = try jsonDecode.decode(TRPOAuthJsonModel.self, from: data)
            self.Completion?(result, nil, nil);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    override public func requestMode() -> TRPRequestMode {
        return TRPRequestMode.post
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.Login.link
    }
    
    public override func bodyParameters() -> Dictionary<String, Any>? {
        return ["username":"\(email)","password":"\(password)"];
    }

}
