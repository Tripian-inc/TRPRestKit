//
//  TRPOauthServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 24.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPLogin: TRPRestServices{
    
    //Airmiles
    private var email:String?
    private var password: String?
    //Test server
    private var userName: String?
    
    /// Login in AirmilesServer
    ///
    /// - Parameters:
    ///   - email: email address
    ///   - password: user password
    init(email:String, password:String) {
        self.email = email
        self.password = password
    }
    
    /// Login in Test Server
    ///
    /// - Parameter userName: User Name
    init(userName: String) {
        self.userName = userName
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
        return TRPConfig.ApiCall.login.link
    }
    
    public override func bodyParameters() -> Dictionary<String, Any>? {
        if let email = email, let password = password {
            return ["email":email, "password":password]
        }
        if let userName = userName {
            return ["username":userName]
        }
        return nil
    }

}
