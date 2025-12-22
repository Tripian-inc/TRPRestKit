//
//  TRPPoiLocationInfoModel.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 22.12.2024.
//  Copyright © 2024 Tripian Inc. All rights reserved.
//

import Foundation

/// This model provides location information for POI
public struct TRPPoiLocationInfoModel: Decodable {

    /// Continent name (e.g., "Europe")
    public var continent: String?
    /// Country name (e.g., "Spain")
    public var country: String?
    /// Type of location
    public var locationType: String?
    /// Name of the location (e.g., "Barcelona")
    public var name: String?
    /// Unique identifier of the location
    public var id: Int?

    private enum CodingKeys: String, CodingKey {
        case continent
        case country
        case locationType
        case name
        case id
    }

    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.continent = try values.decodeIfPresent(String.self, forKey: .continent)
        self.country = try values.decodeIfPresent(String.self, forKey: .country)
        self.locationType = try values.decodeIfPresent(String.self, forKey: .locationType)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
    }
}
