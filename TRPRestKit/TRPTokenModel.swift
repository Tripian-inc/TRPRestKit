//
//  TRPTokenModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 4.06.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPToken: Codable {
    
    public var accessToken: String
    
    public var expiresIn: Int
    
    public var refreshToken: String?
    
    public init(login: TRPLoginInfoModel) {
        accessToken = login.accessToken
        expiresIn = login.expiresIn
        refreshToken = login.refreshToken
    }
    
    public init(refresh: TRPRefreshTokenInfoModel) {
        accessToken = refresh.accessToken
        expiresIn = refresh.expiresIn
        refreshToken = nil
    }
    
    public init(accessToken: String, expiresIn: Int, refreshToken: String?) {
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.refreshToken = refreshToken
    }
}
