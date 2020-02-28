//
//  TRPRefreshTokenService.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 27.02.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPRefreshTokenService: TRPRestServices{
    
    private var refreshToken: String
    
    init(refreshToken: String) {
        self.refreshToken = refreshToken
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
            self.completion?(result, nil, nil)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }
    
    override func requestMode() -> TRPRequestMode {
        return .post
    }
    
    override func bodyParameters() -> [String : Any]? {
        return ["refresh_token": refreshToken]
    }
}

