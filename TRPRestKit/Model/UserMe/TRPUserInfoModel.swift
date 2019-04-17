//
//  TRPUserMeInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// This model provide you to use information of user.
public struct TRPUserInfoModel: Decodable {
    
    
    /// A String value. Name of user.
    public var userName: String
    /// A array of TRPUserPreferencesInfoModel objects.
    public var info: [TRPUserPreferencesInfoModel]?
    
    //TODO: - preferences eklenecek
    private enum CodingKeys: String, CodingKey {
        case userName = "username"
        case info
    }
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
       
        self.userName = try values.decode(String.self, forKey: TRPUserInfoModel.CodingKeys.userName)
        self.info = try values.decodeIfPresent([TRPUserPreferencesInfoModel].self, forKey: TRPUserInfoModel.CodingKeys.info)
    }
    
}

public struct TRPUserPreferencesInfoModel: Decodable {
    
    
    /// An Int value. Unique id of User Preferences.
    public var id: Int;
    /// A String value.
    public var key: String;
    /// A String value.
    public var value: String;

    private enum CodingKeys: String, CodingKey {
        case id
        case key
        case value
    }
    
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        id = try values.decode(Int.self, forKey: .id)
        key = try values.decode(String.self, forKey: .key)
        value = try values.decode(String.self, forKey: .value)
    }
    
}
