//
//  TRPTourScheduleAvailabilityJsonModel.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// Parent JSON parser model for Tour Schedule Availability
public class TRPTourScheduleAvailabilityJsonModel: TRPParentJsonModel {

    /// Availability data wrapper
    public var data: TRPTourScheduleAvailabilityDataModel?

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decodeIfPresent(TRPTourScheduleAvailabilityDataModel.self, forKey: .data)
        try super.init(from: decoder)
    }
}

/// Data wrapper carrying per-activity schedule availability entries
public struct TRPTourScheduleAvailabilityDataModel: Decodable {

    /// Schedule availability entries keyed by activity ID
    public var schedules: [TRPTourScheduleAvailabilityItemModel]?

    private enum CodingKeys: String, CodingKey {
        case schedules
    }
}

/// Single activity entry inside the availability response
public struct TRPTourScheduleAvailabilityItemModel: Decodable {

    /// Activity ID matching the requested `items[]` value
    public var id: String
    /// Schedule with slot-level availability for the requested date
    public var schedule: TRPTourScheduleModel?

    private enum CodingKeys: String, CodingKey {
        case id
        case schedule
    }
}
