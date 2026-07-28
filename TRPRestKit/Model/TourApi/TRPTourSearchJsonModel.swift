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
    /// Faceted search metadata (categories, features, price/duration ranges)
    public var facets: [TRPTourFacetModel]?

    private enum CodingKeys: String, CodingKey {
        case products
        case total
        case limit
        case offset
        case facets
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.products = try values.decodeIfPresent([TRPTourProductInfoModel].self, forKey: .products)
        self.total = try values.decodeIfPresent(Int.self, forKey: .total)
        self.limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        self.offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        self.facets = try values.decodeIfPresent([TRPTourFacetModel].self, forKey: .facets)
    }
}

/// Faceted search metadata grouped by provider
public struct TRPTourFacetModel: Decodable {
    public var provider: String?
    public var source: String?
    public var categories: [TRPTourFacetCategoryModel]?
    public var features: [TRPTourFacetFeatureModel]?
    public var priceRange: TRPTourFacetPriceRangeModel?
    public var durationRange: TRPTourFacetDurationRangeModel?

    private enum CodingKeys: String, CodingKey {
        case provider
        case source
        case categories
        case features
        case priceRange
        case durationRange
    }
}

/// Category facet entry
public struct TRPTourFacetCategoryModel: Decodable {
    public var id: String?
    public var key: String?
    public var label: String?
    public var icon: String?
    public var count: Int?
}

/// Feature facet entry (free cancellation, skip line, etc.)
public struct TRPTourFacetFeatureModel: Decodable {
    public var id: String?
    public var key: String?
    public var label: String?
    public var icon: String?
    public var count: Int?
}

/// Money amount used inside facet price ranges
public struct TRPTourFacetMoneyModel: Decodable {
    public var amount: Int?
    public var currency: String?
}

/// Min/max price pair
public struct TRPTourFacetPriceBoundsModel: Decodable {
    public var minimum: TRPTourFacetMoneyModel?
    public var maximum: TRPTourFacetMoneyModel?
}

/// Price range facet with absolute and current bounds
public struct TRPTourFacetPriceRangeModel: Decodable {
    public var minimum: TRPTourFacetMoneyModel?
    public var maximum: TRPTourFacetMoneyModel?
    public var current: TRPTourFacetPriceBoundsModel?
    public var absolute: TRPTourFacetPriceBoundsModel?
}

/// Min/max duration pair (in minutes)
public struct TRPTourFacetDurationBoundsModel: Decodable {
    public var minimumMinutes: Int?
    public var maximumMinutes: Int?

    private enum CodingKeys: String, CodingKey {
        case minimumMinutes = "minimum_minutes"
        case maximumMinutes = "maximum_minutes"
    }
}

/// Duration range facet
public struct TRPTourFacetDurationRangeModel: Decodable {
    public var minimumMinutes: Int?
    public var maximumMinutes: Int?
    public var current: TRPTourFacetDurationBoundsModel?
    public var absolute: TRPTourFacetDurationBoundsModel?

    private enum CodingKeys: String, CodingKey {
        case minimumMinutes = "minimum_minutes"
        case maximumMinutes = "maximum_minutes"
        case current
        case absolute
    }
}
