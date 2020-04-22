//
//  TRPRefreshTokenService.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 27.02.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPRefreshTokenService: TRPRestServices<TRPGenericParser<TRPRefreshTokenInfoModel>> {
    
    private var refreshToken: String
    
    init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.refresh.link
    }
    
    override func requestMode() -> TRPRequestMode {
        return .post
    }
    override func userOAuth() -> Bool {
        return true
    }
    override func bodyParameters() -> [String: Any]? {
        return ["refresh_token": refreshToken]
    }
}
