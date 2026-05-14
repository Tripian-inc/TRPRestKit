//
//  TRPTourProductLookupJsonModel.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// Parent JSON parser model for Tour Product Lookup
public class TRPTourProductLookupJsonModel: TRPParentJsonModel {

    /// Looked-up product (matches a single TRPTourProductInfoModel from search results)
    public var data: TRPTourProductInfoModel?

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decodeIfPresent(TRPTourProductInfoModel.self, forKey: .data)
        try super.init(from: decoder)
    }
}
