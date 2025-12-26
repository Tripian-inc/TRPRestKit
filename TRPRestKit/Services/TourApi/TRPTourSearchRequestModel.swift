//
//  TRPTourSearchRequestModel.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation

/// Request model for tour search API
public class TRPTourSearchRequestModel {

    // Required parameters
    public var cityId: Int

    // Optional parameters
    public var lat: Double?
    public var lng: Double?
    public var instantAvailability: Int?
    public var providerId: Int?
    public var keywords: String?
    public var tagIds: String?
    public var minPrice: Double?
    public var maxPrice: Double?
    public var adults: Int?
    public var currency: String?
    public var date: String?
    public var hour: String?
    public var minRating: Double?
    public var minDuration: Double?
    public var maxDuration: Double?
    public var lang: String?
    public var offset: Int
    public var limit: Int
    public var radius: Double?
    public var sortingBy: String?
    public var sortingType: String?

    /// Initialize tour search request
    ///
    /// - Parameters:
    ///   - cityId: City ID for the tour search (required)
    ///   - lat: Latitude coordinate (optional)
    ///   - lng: Longitude coordinate (optional)
    ///   - instantAvailability: Filter for instant availability (1 = yes, 0 = no)
    ///   - providerId: Provider ID to filter results
    ///   - keywords: Search keywords
    ///   - tagIds: Comma-separated tag IDs
    ///   - minPrice: Minimum price filter
    ///   - maxPrice: Maximum price filter
    ///   - adults: Number of adults
    ///   - currency: Currency code (e.g., "usd")
    ///   - date: Date for the tour (format: "YYYY-MM-DD")
    ///   - hour: Hour for the tour
    ///   - minRating: Minimum rating filter
    ///   - minDuration: Minimum duration in minutes
    ///   - maxDuration: Maximum duration in minutes
    ///   - lang: Language code (e.g., "en")
    ///   - offset: Pagination offset (default: 0)
    ///   - limit: Number of results per page (default: 30)
    ///   - radius: Search radius in kilometers
    ///   - sortingBy: Sort field (e.g., "price", "rating")
    ///   - sortingType: Sort order ("asc" or "desc")
    public init(
        cityId: Int,
        lat: Double? = nil,
        lng: Double? = nil,
        instantAvailability: Int? = nil,
        providerId: Int? = nil,
        keywords: String? = nil,
        tagIds: String? = nil,
        minPrice: Double? = nil,
        maxPrice: Double? = nil,
        adults: Int? = nil,
        currency: String? = nil,
        date: String? = nil,
        hour: String? = nil,
        minRating: Double? = nil,
        minDuration: Double? = nil,
        maxDuration: Double? = nil,
        lang: String? = nil,
        offset: Int = 0,
        limit: Int = 30,
        radius: Double? = nil,
        sortingBy: String? = nil,
        sortingType: String? = nil
    ) {
        self.cityId = cityId
        self.lat = lat
        self.lng = lng
        self.instantAvailability = instantAvailability
        self.providerId = providerId
        self.keywords = keywords
        self.tagIds = tagIds
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.adults = adults
        self.currency = currency
        self.date = date
        self.hour = hour
        self.minRating = minRating
        self.minDuration = minDuration
        self.maxDuration = maxDuration
        self.lang = lang
        self.offset = offset
        self.limit = limit
        self.radius = radius
        self.sortingBy = sortingBy
        self.sortingType = sortingType
    }

    /// Convert request model to dictionary for API call
    internal func toDictionary() -> [String: Any] {
        var params: [String: Any] = [:]

        // Required parameters
        params["cityId"] = cityId

        // Optional parameters
        if let lat = lat {
            params["lat"] = lat
        }
        if let lng = lng {
            params["lng"] = lng
        }
        if let instantAvailability = instantAvailability {
            params["instantAvailability"] = instantAvailability
        }
        if let providerId = providerId {
            params["providerId"] = providerId
        }
        if let keywords = keywords, !keywords.isEmpty {
            params["keywords"] = keywords
        }
        if let tagIds = tagIds, !tagIds.isEmpty {
            params["tagIds"] = tagIds
        }
        if let minPrice = minPrice {
            params["minPrice"] = minPrice
        }
        if let maxPrice = maxPrice {
            params["maxPrice"] = maxPrice
        }
        if let adults = adults {
            params["adults"] = adults
        }
        if let currency = currency {
            params["currency"] = currency
        }
        if let date = date {
            params["date"] = date
        }
        if let hour = hour {
            params["hour"] = hour
        }
        if let minRating = minRating {
            params["minRating"] = minRating
        }
        if let minDuration = minDuration {
            params["minDuration"] = minDuration
        }
        if let maxDuration = maxDuration {
            params["maxDuration"] = maxDuration
        }
        if let lang = lang {
            params["lang"] = lang
        }
        if let radius = radius {
            params["radius"] = radius
        }
        if let sortingBy = sortingBy {
            params["sortingBy"] = sortingBy
        }
        if let sortingType = sortingType {
            params["sortingType"] = sortingType
        }

        params["offset"] = offset
        params["limit"] = limit

        return params
    }
}
