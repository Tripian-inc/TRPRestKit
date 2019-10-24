//
//  TRPLoginJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 11.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// Indicates a informaion of login.
public struct TRPLoginInfoModel: Decodable {
    
    /// Type of token
    public var tokenType: String?
    
    /// Token access key
    public var accessToken: String
    
    private enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
    }
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.tokenType = try values.decodeIfPresent(String.self, forKey: .tokenType)
        self.accessToken = try values.decode(String.self, forKey: .accessToken)
    }
    
}
