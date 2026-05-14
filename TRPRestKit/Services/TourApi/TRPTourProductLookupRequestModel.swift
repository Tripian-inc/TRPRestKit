//
//  TRPTourProductLookupRequestModel.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// Request model for tour product lookup API
public class TRPTourProductLookupRequestModel {

    public var providerId: Int
    public var productId: String

    /// Initialize tour product lookup request
    ///
    /// - Parameters:
    ///   - providerId: Provider ID (e.g., 15)
    ///   - productId: Provider-specific product identifier (e.g., "14053")
    public init(providerId: Int, productId: String) {
        self.providerId = providerId
        self.productId = productId
    }

    internal func toDictionary() -> [String: Any] {
        return [
            "providerId": providerId,
            "productId": productId
        ]
    }
}
