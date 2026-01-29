//
//  TRPCityResolveInfoModel.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 29.01.2026.
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

public struct TRPCityResolveInfoModel: Decodable {

    public var cityId: Int
    public var coordinate: TRPLocation?
    public var cityName: String?
    public var countryName: String?

    private enum CodingKeys: String, CodingKey {
        case cityId
        case coordinate
        case cityName
        case countryName
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.cityId = try values.decode(Int.self, forKey: .cityId)
        self.coordinate = try values.decodeIfPresent(TRPLocation.self, forKey: .coordinate)
        self.cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
        self.countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
    }
}
