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
    /// A String value. Email of the user.
    public var email: String
    /// A String value. First name of the user.
    public var firstName: String?
    /// A String value. Age of the user.
    public var age: String?
    /// A String value. Last name of the user.
    public var lastName: String?
    /// A String value. Password of the user.
    public var password: String?
    /// An Int value. Payment status of the user.
    public var paymentStatus: Int?
    /// A array of TRPUserPreferencesInfoModel objects.
    public var info: [TRPUserPreferencesInfoModel]?
    
    //TODO: - preferences eklenecek
    private enum CodingKeys: String, CodingKey {
        case email
        case info
        case firstName = "first_name"
        case lastName = "last_name"
        case password
        case age
        case paymentStatus = "payment_status"
    }
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
       
        self.email = try values.decode(String.self, forKey: .email)
        self.firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        self.password = try values.decodeIfPresent(String.self, forKey: .password)
        self.age = try values.decodeIfPresent(String.self, forKey: .age)
        self.paymentStatus = try values.decodeIfPresent(Int.self, forKey: .paymentStatus)
        self.info = try values.decodeIfPresent([TRPUserPreferencesInfoModel].self, forKey: .info)
    }
    
}

/// This model provide you to use information of user.
public struct TRPTestUserInfoModel: Decodable {
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
        
        self.userName = try values.decode(String.self, forKey: .userName)
        self.info = try values.decodeIfPresent([TRPUserPreferencesInfoModel].self, forKey: .info)
    }
    
}



/// Indicate preferences of user with Key/Value.
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
