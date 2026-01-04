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
    /// Array of available time slots
    public var slots: [TRPTourScheduleSlot]?

    private enum CodingKeys: String, CodingKey {
        case productId
        case title
        case date
        case tags
        case duration
        case slots
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
    }
}

/// Tour schedule time slot model
public struct TRPTourScheduleSlot: Decodable {
    /// Time of the slot (e.g., "08:45")
    public var time: String?
    /// Price for this time slot
    public var price: Double?
    /// Full refund available
    public var fullRefund: Bool?

    private enum CodingKeys: String, CodingKey {
        case time
        case price
        case fullRefund
    }
}
