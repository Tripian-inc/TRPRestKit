//
//  TRPTourScheduleRequestModel.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation

/// Request model for tour schedule API
public class TRPTourScheduleRequestModel {

    // Required parameters
    public var productId: String
    public var date: String

    // Optional parameters
    public var to: String?
    public var currency: String?
    public var lang: String?

    /// Initialize tour schedule request
    ///
    /// - Parameters:
    ///   - productId: Product ID for the tour (required)
    ///   - date: Start date for the schedule range (format: "YYYY-MM-DD") (required)
    ///   - to: End date for the schedule range (format: "YYYY-MM-DD", optional). When provided,
    ///         response includes a populated `dates` array with per-day slot lists.
    ///   - currency: Currency code (e.g., "USD")
    ///   - lang: Language code (e.g., "en")
    public init(
        productId: String,
        date: String,
        to: String? = nil,
        currency: String? = nil,
        lang: String? = nil
    ) {
        self.productId = productId
        self.date = date
        self.to = to
        self.currency = currency
        self.lang = lang
    }

    /// Convert request model to dictionary for API call
    internal func toDictionary() -> [String: Any] {
        var params: [String: Any] = [:]

        // Required parameters
        params["date"] = date

        // Optional parameters
        if let to = to {
            params["to"] = to
        }
        if let currency = currency {
            params["currency"] = currency
        }
        if let lang = lang {
            params["lang"] = lang
        }

        return params
    }
}
