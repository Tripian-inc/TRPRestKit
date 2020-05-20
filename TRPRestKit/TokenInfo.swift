//
//  TokenInfo.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 22.04.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
struct TokenInfo: Codable {
    
    var accessToken: String
    
    var expiresIn: Int
    
    var refreshToken: String?
    
    init(login: TRPLoginInfoModel) {
        accessToken = login.accessToken
        expiresIn = login.expiresIn
        refreshToken = login.refreshToken
    }
    
    init(refresh: TRPRefreshTokenInfoModel) {
        accessToken = refresh.accessToken
        expiresIn = refresh.expiresIn
        refreshToken = nil
    }
    
}
