//
//  TRPPoiAddRouteInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 23.11.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPPoiAddRouteInfoModel: Decodable {
    public var id: Int
    public var hash: String
    public var poiId: Int?
    public var order: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case hash
        case poiId = "poi_id"
        case order = "order"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decode(Int.self, forKey: .id)
        self.hash = try values.decode(String.self, forKey: .hash)
        //TODO: - Int düzenlenmesi yapılırsa bir alttaki satır silinecek.
        //self.poiId = try values.decodeIfPresent(Int.self, forKey: .poiId)
        self.order = try values.decode(Int.self, forKey: .order)
    }
    
}
