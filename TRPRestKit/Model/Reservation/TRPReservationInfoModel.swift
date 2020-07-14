//
//  TRPReservationInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 14.07.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPReservationInfoModel: Decodable {
    
    let id: Int
    let key: String
    //let value: Any?
    let provider, tripHash: String
    let poiID: Int
    let createdAt: String
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, key, provider
        case tripHash = "trip_hash"
        case poiID = "poi_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}
