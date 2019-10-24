//
//  TRPPlanPoint.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 12.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// Infomation of Plan Poi.
public struct TRPPlanPoi: Decodable, Equatable, Hashable {
    /// An Int value. Id of PlanPoi
    public var id: Int
    /// An Int value. Id of Poi
    public var poiId: Int
    /// An Int value. Order of PlanPoi
    public var order: Int
    /// A String value. Hash of Trip
    public var hash: String?
    
    public var hashValue: Int {
        return poiId.hashValue
    }
    
    public static func ==(lhs: TRPPlanPoi, rhs: TRPPlanPoi) -> Bool {
        return lhs.poiId == rhs.poiId
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case poiId = "poi_id"
        case order
        case hash
    }
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        poiId = try values.decode(Int.self, forKey: .poiId)
        order = try values.decode(Int.self, forKey: .order)
        hash = try values.decodeIfPresent(String.self, forKey: .hash)
    }
    
}
