//
//  TRPPlanPoint.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 12.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPPlanPoi: Decodable {

    public var id: Int
    public var poiId: Int
    public var order: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case poiId = "poi_id"
        case order
        case dailyPlanId = "dailyplan_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        id = try values.decode(Int.self, forKey: .id)
        poiId = try values.decode(Int.self, forKey: .poiId)
        order = try values.decode(Int.self, forKey: .order)
       // dailyPlanId = try? values.decodeIfPresent(Int.self, forKey: TRPPlanPoi.CodingKeys.dailyPlanId)
    }
    
}
