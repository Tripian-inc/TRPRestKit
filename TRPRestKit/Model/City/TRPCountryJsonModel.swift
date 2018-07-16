//
//  TRPCountryJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPCountryJsonModel: Decodable {
    
    public var code: String?;
    public var name: String?;
    public var continient: String?;
    
    enum CodingKeys: String, CodingKey{
        case code
        case name
        case continent
    }
    
    enum ContinientKeys:String, CodingKey {
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try values.decodeIfPresent(String.self, forKey: .code)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        //For continient
        let continientContainer = try values.nestedContainer(keyedBy: ContinientKeys.self, forKey: .continent)
        self.continient = try continientContainer.decodeIfPresent(String.self, forKey: .name)
    }
    
}
