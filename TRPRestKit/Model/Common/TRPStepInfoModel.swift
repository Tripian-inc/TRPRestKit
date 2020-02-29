//
//  TRPPlanPoint.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 12.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// Infomation of Plan Poi.
public struct TRPStepInfoModel: Decodable {
    /// An Int value. Id of PlanPoi
    public var id: Int
    
    public var poi: TRPPoiInfoModel
    /// An Int value. Order of PlanPoi
    public var order: Int
    
    public var score: Int?
    public var alternatives: [Int]?
    public var hours:TRPHourInfoModel?
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case poi
        case score
        case hours
        case order
        case alternatives
    }
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        poi = try values.decode(TRPPoiInfoModel.self, forKey: .poi)
        score = try values.decodeIfPresent(Int.self, forKey: .score)
        hours = try values.decodeIfPresent(TRPHourInfoModel.self, forKey: .hours)
        alternatives = try values.decodeIfPresent([Int].self, forKey: .alternatives)
        order = try values.decode(Int.self,forKey: .order)
    }
    
}


public struct TRPHourInfoModel: Decodable {
    var from: String?
    var to: String?
}
