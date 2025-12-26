//
//  TRPTourProductInfoModel.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation

/// This model provides full information of a tour product
public struct TRPTourProductInfoModel: Decodable {

    /// Product ID (e.g., "41830")
    public var productId: String
    /// Provider ID
    public var providerId: Int
    /// Unique identifier combining provider and product (e.g., "C_41830_15")
    public var id: String
    /// City ID where the tour is located
    public var cityId: Int
    /// Title of the tour
    public var title: String
    /// Description of the tour
    public var description: String?
    /// Product URL for redirection
    public var url: String?
    /// Price in the specified currency
    public var price: Double?
    /// Currency code (e.g., "USD")
    public var currency: String?
    /// Current price in cents
    public var currentPrice: Double?
    /// Duration in minutes
    public var duration: Double?
    /// Rating score
    public var rating: Double?
    /// Number of ratings
    public var ratingCount: Int?
    /// Product status (1 = active)
    public var status: Int?
    /// Availability status
    public var available: Bool?
    /// API version
    public var version: String?

    /// Array of product images
    public var images: [TRPTourImageModel]?
    /// Array of location names
    public var locationNames: [String]?
    /// Array of tag IDs
    public var tagIds: [Int]?
    /// Array of tag names
    public var tags: [String]?
    /// Array of coordinates
    public var locations: [TRPTourLocationModel]?
    /// Array of related Tripian POIs
    public var tripianPois: [String]?

    private enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case providerId = "provider_id"
        case id
        case cityId = "city_id"
        case title
        case description
        case url
        case price
        case currency
        case currentPrice = "current_price"
        case duration
        case rating
        case ratingCount = "rating_count"
        case status
        case available
        case version
        case images
        case locationNames = "location_names"
        case tagIds = "tag_ids"
        case tags
        case locations
        case tripianPois = "tripian_pois"
    }

    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.productId = try values.decode(String.self, forKey: .productId)
        self.providerId = try values.decode(Int.self, forKey: .providerId)
        self.id = try values.decode(String.self, forKey: .id)
        self.cityId = try values.decode(Int.self, forKey: .cityId)
        self.title = try values.decode(String.self, forKey: .title)

        self.description = try values.decodeIfPresent(String.self, forKey: .description)
        self.url = try values.decodeIfPresent(String.self, forKey: .url)
        self.price = try values.decodeIfPresent(Double.self, forKey: .price)
        self.currency = try values.decodeIfPresent(String.self, forKey: .currency)
        self.currentPrice = try values.decodeIfPresent(Double.self, forKey: .currentPrice)
        self.duration = try values.decodeIfPresent(Double.self, forKey: .duration)
        self.rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        self.ratingCount = try values.decodeIfPresent(Int.self, forKey: .ratingCount)
        self.status = try values.decodeIfPresent(Int.self, forKey: .status)
        self.available = try values.decodeIfPresent(Bool.self, forKey: .available)
        self.version = try values.decodeIfPresent(String.self, forKey: .version)

        self.images = try values.decodeIfPresent([TRPTourImageModel].self, forKey: .images)
        self.locationNames = try values.decodeIfPresent([String].self, forKey: .locationNames)
        self.tagIds = try values.decodeIfPresent([Int].self, forKey: .tagIds)
        self.tags = try values.decodeIfPresent([String].self, forKey: .tags)
        self.locations = try values.decodeIfPresent([TRPTourLocationModel].self, forKey: .locations)
        self.tripianPois = try values.decodeIfPresent([String].self, forKey: .tripianPois)
    }
}

/// Tour image model
public struct TRPTourImageModel: Decodable {
    /// Whether this is the cover image
    public var isCover: Bool?
    /// Image URL
    public var url: String?

    private enum CodingKeys: String, CodingKey {
        case isCover = "is_cover"
        case url
    }
}

/// Tour location coordinate model
public struct TRPTourLocationModel: Decodable {
    /// Latitude
    public var lat: Double?
    /// Longitude
    public var lon: Double?

    private enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
}
