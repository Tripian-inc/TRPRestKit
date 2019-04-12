//
//  NearByJsonInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPPlanPointAlternativeInfoModel: Decodable {
    public var id: Int
    public var hash: String
    public var alternativePoiId: Int
    public var dailyPlanPoi: TRPPlanPoi?

    private enum CodingKeys: String, CodingKey {
        case id
        case hash
        case poiId = "poi_id"
        case planPoint = "dailyplanpoi"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decode(Int.self, forKey: .id)
        self.hash = try values.decode(String.self, forKey: .hash)
        self.alternativePoiId = try values.decode(Int.self, forKey: .poiId)
        
        if let points = try? values.decodeIfPresent(TRPPlanPoi.self, forKey: .planPoint) {
            self.dailyPlanPoi = points
        }
    }
    
}
