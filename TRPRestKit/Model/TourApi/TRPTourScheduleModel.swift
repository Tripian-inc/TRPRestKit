//
//  TRPTourScheduleModel.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation

/// This model provides schedule information for a tour product
public struct TRPTourScheduleModel: Decodable {

    /// Product ID
    public var productId: String
    /// Title of the tour
    public var title: String
    /// Date of the tour (format: "YYYY-MM-DD")
    public var date: String
    /// Array of tags
    public var tags: [String]?
    /// Duration in minutes
    public var duration: Double?
    /// Array of available time slots (single-date queries; usually empty when `dates` is populated)
    public var slots: [TRPTourScheduleSlot]?
    /// Per-day slot breakdown when the request used a date range (`to` parameter)
    public var dates: [TRPTourScheduleDateModel]?

    private enum CodingKeys: String, CodingKey {
        case productId
        case title
        case date
        case tags
        case duration
        case slots
        case dates
    }

    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.productId = try values.decode(String.self, forKey: .productId)
        self.title = try values.decode(String.self, forKey: .title)
        self.date = try values.decode(String.self, forKey: .date)

        self.tags = try values.decodeIfPresent([String].self, forKey: .tags)
        self.duration = try values.decodeIfPresent(Double.self, forKey: .duration)
        self.slots = try values.decodeIfPresent([TRPTourScheduleSlot].self, forKey: .slots)
        self.dates = try values.decodeIfPresent([TRPTourScheduleDateModel].self, forKey: .dates)
    }
}

/// Tour schedule time slot model
public struct TRPTourScheduleSlot: Decodable {
    /// Slot date (often empty inside a `TRPTourScheduleDateModel`; outer `dates[].date` carries the day)
    public var date: String?
    /// Time of the slot (e.g., "08:45")
    public var time: String?
    /// Price for this time slot
    public var price: Double?
    /// Full refund available
    public var fullRefund: Bool?
    /// Remaining capacity for the slot (populated by `tour-api/schedule-availability`)
    public var availableCount: Int?

    private enum CodingKeys: String, CodingKey {
        case date
        case time
        case price
        case fullRefund
        case availableCount
    }
}

/// Per-day slot bucket used when the schedule request spans a date range
public struct TRPTourScheduleDateModel: Decodable {
    /// Day this bucket covers (format: "YYYY-MM-DD")
    public var date: String?
    /// Available slots for this day; empty array means no availability
    public var slots: [TRPTourScheduleSlot]?

    private enum CodingKeys: String, CodingKey {
        case date
        case slots
    }
}
