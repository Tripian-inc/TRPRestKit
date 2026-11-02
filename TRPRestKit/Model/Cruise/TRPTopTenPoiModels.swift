//
//  TRPTopTenPoiModels.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// The ten most recommended pois of a city in one category.
public struct TRPTopTenPoisModel: Decodable {
    public let category: TRPTopTenCategoryModel
    public let topTenPoi: [TRPTopTenPoiModel]
}

public struct TRPTopTenCategoryModel: Codable {
    public let id: Int
    public let name: String
}

public struct TRPTopTenPoiModel: Decodable {
    public let id: String
    public let cityId: Int
    public let name: String
    public let image: TRPImageModel
    public let gallery: [TRPImageModel]?
    public let price: Int?
    public let rating: Float?
    public let ratingCount: Int?
    public let description: String?
    public let webUrl: String?
    public let phone: String?
    public let hours: String?
    public let address: String?
    public let icon: String
}
