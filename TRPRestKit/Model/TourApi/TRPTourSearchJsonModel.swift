//
//  TRPTourSearchJsonModel.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation

/// Parent Json parser model for Tour Search
public class TRPTourSearchJsonModel: TRPParentJsonModel {

    /// Tour search data wrapper
    public var data: TRPTourSearchDataModel?

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decodeIfPresent(TRPTourSearchDataModel.self, forKey: .data)
        try super.init(from: decoder)
    }
}

/// Tour search data model containing products and pagination info
public struct TRPTourSearchDataModel: Decodable {

    /// Array of tour products
    public var products: [TRPTourProductInfoModel]?
    /// Total number of results
    public var total: Int?
    /// Limit per page
    public var limit: Int?
    /// Offset for pagination
    public var offset: Int?

    private enum CodingKeys: String, CodingKey {
        case products
        case total
        case limit
        case offset
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.products = try values.decodeIfPresent([TRPTourProductInfoModel].self, forKey: .products)
        self.total = try values.decodeIfPresent(Int.self, forKey: .total)
        self.limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        self.offset = try values.decodeIfPresent(Int.self, forKey: .offset)
    }
}
