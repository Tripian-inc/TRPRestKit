//
//  TRPTypeInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPCategoryInfoModel: Decodable {
    
    public var id: Int
    public var name: String
    public var description: String?;
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decode(Int.self, forKey: .id);
        self.name = try values.decode(String.self, forKey: .name);
        self.description = try values.decodeIfPresent(String.self, forKey: .description);
    }
    
}
