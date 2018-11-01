//
//  TRPOauthServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 24.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPLogin: TRPRestServices{
    
    private var name: String
    private var password: String
    
    init(userName name: String, password: String){
        self.name = name
        self.password = password
    }
    
    override func servicesResult(data: Data?, error: NSError?) {
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
            let result = try jsonDecode.decode(TRPLoginJsonModel.self, from: data)
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
        return ["username":"\(name)","password":"\(password)"];
    }

}
