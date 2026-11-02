//
//  TRPRestKit+Cruise.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

// MARK: - Cruise catalog
extension TRPRestKit {

    /// - Parameter date: a month as `TRPCruiseDateModel.date` gives it.
    public func cruiseBrands(date: String,
                             search: String? = nil,
                             limit: Int? = nil,
                             page: Int? = nil,
                             completion: @escaping ResultHandler<[TRPCruiseBrandModel]>) {
        send(.cruiseBrands(date: date, search: search, limit: limit, page: page), completion: completion)
    }

    public func cruiseShips(brandId: Int,
                            date: String,
                            search: String? = nil,
                            limit: Int? = nil,
                            page: Int? = nil,
                            completion: @escaping ResultHandler<[TRPCruiseShipModel]>) {
        send(.cruiseShips(brandId: brandId, date: date, search: search, limit: limit, page: page), completion: completion)
    }

    public func cruiseDates(limit: Int? = nil,
                            page: Int? = nil,
                            completion: @escaping ResultHandler<[TRPCruiseDateModel]>) {
        send(.cruiseDates(limit: limit, page: page), completion: completion)
    }

    public func cruiseShipDates(brandId: Int,
                                limit: Int? = nil,
                                page: Int? = nil,
                                completion: @escaping ResultHandler<[TRPCruiseDateModel]>) {
        send(.cruiseShipDates(brandId: brandId, limit: limit, page: page), completion: completion)
    }

    public func cruises(brandId: Int,
                        date: String,
                        portId: Int? = nil,
                        shipId: Int? = nil,
                        completion: @escaping ResultHandler<[TRPCruiseModel]>) {
        send(.cruises(brandId: brandId, date: date, portId: portId, shipId: shipId), completion: completion)
    }

    public func cruiseOverview(cruiseId: Int, completion: @escaping ResultHandler<TRPCruiseOverviewModel>) {
        send(.cruiseOverview(cruiseId: cruiseId), completion: completion)
    }
}

// MARK: - Cruise ports
extension TRPRestKit {

    public func cruisePorts(brandId: Int,
                            date: String,
                            cityId: Int? = nil,
                            search: String? = nil,
                            limit: Int? = nil,
                            page: Int? = nil,
                            completion: @escaping ResultHandler<[TRPCruisePortGroupModel]>) {
        send(.cruisePorts(brandId: brandId, date: date, cityId: cityId, search: search, limit: limit, page: page),
             completion: completion)
    }

    /// - Parameter isCity: true when `portId` is a city id rather than a port id.
    public func cruisePortInfo(portId: Int,
                               isCity: Bool,
                               completion: @escaping ResultHandler<[TRPCruisePortInfoModel]>) {
        send(.cruisePortInfo(portId: portId, isCity: isCity), completion: completion)
    }
}
