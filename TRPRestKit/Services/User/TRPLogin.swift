//
//  TRPOauthServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 24.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPLogin: TRPRestServices {
    
    //Airmiles
    private var email: String?
    private var password: String?
    //Test server
    private var loginParameters: [String: String]
    
    
    init?(parameters: [String: String]) {
        if parameters.count == 0 {
            return nil
        }
        for param in parameters {
            if param.key.isEmpty || param.value.isEmpty {
                return nil
            }
        }
        loginParameters  = parameters
    }
    
    override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.completion?(nil, error, nil)
            return
        }
        guard let data = data else {
            self.completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        
        let jsonDecode = JSONDecoder()
        do {
            let result = try jsonDecode.decode(TRPGenericParser<TRPLoginTokenInfoModel>.self, from: data)
            //let result = try jsonDecode.decode(TRPLoginJsonModel.self, from: data)
            self.completion?(result, nil, nil)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }
    
    override public func requestMode() -> TRPRequestMode {
        return TRPRequestMode.post
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.login.link
    }
    
    public override func bodyParameters() -> [String: Any]? {
        return loginParameters
    }

}
