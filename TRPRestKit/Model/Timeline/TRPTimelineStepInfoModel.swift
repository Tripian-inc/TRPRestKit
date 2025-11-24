//
//  TRPPlanPoint.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 12.09.2018.
//  Copyright © 2018 Tripian Inc. All rights reserved.
//

import Foundation

/// Infomation of Plan Poi.
public struct TRPTimelineStepInfoModel: Decodable, Hashable {

    /// Unique identifier for the PlanPoi
    public var id: Int
    
    /// POI (Point of Interest) information
    public var poi: TRPPoiInfoModel
    /// Sequence order of the PlanPoi in the timeline
    public var order: Int = 0
    /// Optional Plan identifier
    public var planId: String?
    
    /// Optional score for the step
    public var score: Double?
    /// Optional start date/time for the step
    public var startDateTimes: String?
    /// Optional end date/time for the step
    public var endDateTimes: String?
    /// Optional type of the step
    public var stepType: String?
    /// Optional warning message for the step
    public var warningMessage: [String]?
    /// List of alternative options for the step
    public var alternatives: [String]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case poi
        case score
        case startDateTimes
        case endDateTimes
        case stepType
        case order
        case alternatives
        case planId
        case warningMessage
    }
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        poi = try values.decode(TRPPoiInfoModel.self, forKey: .poi)
        score = try values.decodeIfPresent(Double.self, forKey: .score)
        startDateTimes = try values.decodeIfPresent(String.self, forKey: .startDateTimes)
        endDateTimes = try values.decodeIfPresent(String.self, forKey: .endDateTimes)
        planId = try values.decodeIfPresent(String.self, forKey: .planId)
        stepType = try values.decodeIfPresent(String.self, forKey: .stepType)
        warningMessage = try values.decodeIfPresent([String].self, forKey: .warningMessage)
        alternatives = try values.decode([String].self, forKey: .alternatives)
        order = try values.decode(Int.self, forKey: .order)
    }
    
    public static func == (lhs: TRPTimelineStepInfoModel, rhs: TRPTimelineStepInfoModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    public static func < (lhs: TRPTimelineStepInfoModel, rhs: TRPTimelineStepInfoModel) -> Bool {
        return lhs.order < rhs.order
    }
    
    public func hash(into hasher: inout Hasher) {}
    
}
