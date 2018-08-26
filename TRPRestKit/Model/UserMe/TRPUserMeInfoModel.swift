//
//  TRPUserMeInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPUserMeInfoModel: Decodable {
    
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    
    //TODO: - preferences eklenecek
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decode(Int.self, forKey: TRPUserMeInfoModel.CodingKeys.id)
        self.firstName = try values.decode(String.self, forKey: TRPUserMeInfoModel.CodingKeys.firstName)
        self.lastName = try values.decode(String.self, forKey: TRPUserMeInfoModel.CodingKeys.lastName)
        self.email = try values.decode(String.self, forKey: TRPUserMeInfoModel.CodingKeys.email)
    }
    
}
