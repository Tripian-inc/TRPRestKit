//
//  TRPProgramStepInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPPlanPointInfoModel: Decodable {
    
    public var id: Int;
    public var hash: String;
    public var placeId: Int
    public var order: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case hash
        
        case placeId = "poi_id"
        case order
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        id = try values.decode(Int.self, forKey: .id)
        hash = try values.decode(String.self, forKey: .hash)
        if let placeId: String = try values.decodeIfPresent(String.self, forKey: .placeId), let id = Int(placeId) {
            self.placeId = id
        }else if let placeId = try values.decodeIfPresent(Int.self, forKey: .placeId) {
            self.placeId = placeId
        }else {
            self.placeId = 0
        }
        
        order = try values.decode(Int.self, forKey: .order)
    }
    
}
