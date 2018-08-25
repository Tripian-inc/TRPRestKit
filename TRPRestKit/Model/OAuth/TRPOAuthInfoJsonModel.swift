//
//  TRPOAuthInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPOAuthInfoJsonModel: Decodable {
    
    public var tokenType: String?;
    public var expiresIn: Int?
    public var accessToken: String;
    public var refresToken: String;
    
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.tokenType = try values.decodeIfPresent(String.self, forKey: .tokenType)
        self.expiresIn = try values.decodeIfPresent(Int.self, forKey: .expiresIn)
        self.accessToken = try values.decode(String.self, forKey: .accessToken)
        self.refresToken = try values.decode(String.self, forKey: .refreshToken)
    }
    
}
