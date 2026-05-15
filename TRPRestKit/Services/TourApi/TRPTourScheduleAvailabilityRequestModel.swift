//
//  TRPTourScheduleAvailabilityRequestModel.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// Request model for tour schedule availability API
public class TRPTourScheduleAvailabilityRequestModel {

    public var items: [String]
    public var date: String
    public var currency: String?
    public var lang: String?

    /// Initialize tour schedule availability request
    ///
    /// - Parameters:
    ///   - items: Activity IDs to check availability for (e.g., ["C_163295_15_109"])
    ///   - date: Target date (format: "YYYY-MM-DD")
    ///   - currency: Currency code (e.g., "EUR")
    ///   - lang: Language code (e.g., "en")
    public init(
        items: [String],
        date: String,
        currency: String? = nil,
        lang: String? = nil
    ) {
        self.items = items
        self.date = date
        self.currency = currency
        self.lang = lang
    }

    internal func toDictionary() -> [String: Any] {
        var params: [String: Any] = [
            "items": items,
            "date": date
        ]
        if let currency = currency {
            params["currency"] = currency
        }
        if let lang = lang {
            params["lang"] = lang
        }
        return params
    }
}
