//
//  TRPRestKit+TopTenPoi.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

// MARK: - Top ten pois
extension TRPRestKit {

    /// - Parameter poiCategories: limits the answer to these categories; every category when nil.
    public func topTenPois(cityId: Int,
                           poiCategories: [Int]? = nil,
                           completion: @escaping ResultHandler<[TRPTopTenPoisModel]>) {
        send(.topTenPois(cityId: cityId, poiCategories: poiCategories), completion: completion)
    }
}
