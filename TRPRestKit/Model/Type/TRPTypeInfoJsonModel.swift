//
//  TRPTypeInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPTypeInfoJsonModel: Decodable {
    
    public var id: Int?;
    public var type: String?;
    public var description: String?;
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case description
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decodeIfPresent(Int.self, forKey: .id);
        self.type = try values.decodeIfPresent(String.self, forKey: .type);
        self.description = try values.decodeIfPresent(String.self, forKey: .description);
    }
    
}
