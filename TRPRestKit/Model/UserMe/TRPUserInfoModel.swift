//
//  TRPUserMeInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPUserInfoModel: Decodable {
    
    public var userName: String
    public var info: [TRPUserPreferencesInfoModel]?
    //TODO: - preferences eklenecek
    enum CodingKeys: String, CodingKey {
        
        case userName = "username"
        case info
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
       
        self.userName = try values.decode(String.self, forKey: TRPUserInfoModel.CodingKeys.userName)
        self.info = try values.decodeIfPresent([TRPUserPreferencesInfoModel].self, forKey: TRPUserInfoModel.CodingKeys.info)
    }
    
}

public struct TRPUserPreferencesInfoModel: Decodable {
    
    public var id: Int;
    public var key: String;
    public var value: String;
    
    enum CodingKeys: String, CodingKey {
        case id
        case key
        case value
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        id = try values.decode(Int.self, forKey: .id)
        key = try values.decode(String.self, forKey: .key)
        value = try values.decode(String.self, forKey: .value)
    }
    
}
