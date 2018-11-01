//
//  TRPRoutesResultPlaceJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRoutesResultPlaceJsonModel:Decodable {
    
    public var id: Int?;
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        id = try values.decodeIfPresent(Int.self, forKey: .id);
    }
    
}
