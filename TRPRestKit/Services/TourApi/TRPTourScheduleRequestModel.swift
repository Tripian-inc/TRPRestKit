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
    public var currency: String?
    public var lang: String?

    /// Initialize tour schedule request
    ///
    /// - Parameters:
    ///   - productId: Product ID for the tour (required)
    ///   - date: Date for the tour (format: "YYYY-MM-DD") (required)
    ///   - currency: Currency code (e.g., "USD")
    ///   - lang: Language code (e.g., "en")
    public init(
        productId: String,
        date: String,
        currency: String? = nil,
        lang: String? = nil
    ) {
        self.productId = productId
        self.date = date
        self.currency = currency
        self.lang = lang
    }

    /// Convert request model to dictionary for API call
    internal func toDictionary() -> [String: Any] {
        var params: [String: Any] = [:]

        // Required parameters
        params["date"] = date

        // Optional parameters
        if let currency = currency {
            params["currency"] = currency
        }
        if let lang = lang {
            params["lang"] = lang
        }

        return params
    }
}
