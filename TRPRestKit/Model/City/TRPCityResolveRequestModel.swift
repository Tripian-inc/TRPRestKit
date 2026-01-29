//
//  TRPCityResolveRequestModel.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 29.01.2026.
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

public struct TRPCityResolveNameRequest {

    public var cityName: String
    public var countryName: String

    public init(cityName: String, countryName: String) {
        self.cityName = cityName
        self.countryName = countryName
    }

    internal func toDictionary() -> [String: Any] {
        return [
            "cityName": cityName,
            "countryName": countryName
        ]
    }
}
