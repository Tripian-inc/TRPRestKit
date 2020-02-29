//
//  NearByJsonInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// Indicates alternative of the plan poi.
public struct TRPPlanPointAlternativeInfoModel: Decodable {
    
    /// An Int value. Id of Alternative
    public var id: Int
    /// A String value. Hash of trip
    public var hash: String
    /// An Int value. Alternative poi Id.
    public var alternativePoiId: Int
    /// Referance plan poi
    public var dailyPlanPoi: TRPStepInfoModel?

    private enum CodingKeys: String, CodingKey {
        case id
        case hash
        case poiId = "poi_id"
        case planPoint = "dailyplanpoi"
    }
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.hash = try values.decode(String.self, forKey: .hash)
        self.alternativePoiId = try values.decode(Int.self, forKey: .poiId)
        
        if let points = ((try? values.decodeIfPresent(TRPStepInfoModel.self, forKey: .planPoint)) as TRPStepInfoModel??) {
            self.dailyPlanPoi = points
        }
    }
    
}
