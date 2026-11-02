//
//  TRPCruiseModels.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// A cruise line.
public struct TRPCruiseBrandModel: Codable {
    public let id: Int
    public let name: String
    public let logo: String?
    public let popular: Bool?
}

/// A ship as listed under a cruise line.
public struct TRPCruiseShipModel: Codable {
    public let id: Int
    public let brandId: Int
    public let name: String
    public let logo: String?
}

/// A month cruises sail in: `date` is what the other catalog calls take, `name` is for display.
public struct TRPCruiseDateModel: Codable {
    public let date: String
    public let name: String
}

/// A ship as embedded in a cruise, with its cruise line.
public struct TRPCruiseShipItemModel: Codable {
    public let id: Int
    public let name: String
    public let image: String
    public let brand: TRPCruiseBrandModel
}

/// A sailing in the catalog.
public struct TRPCruiseModel: Codable {
    public let id: Int
    public let name: String
    public let roundtrip: Bool
    public let manuel: Bool
    public let nights: Int
    public let departure: String
    public let arrival: String
    public let departurePort: TRPCruisePortItemModel
    public let arrivalPort: TRPCruisePortItemModel
    public let ship: TRPCruiseShipItemModel
}

/// A sailing with the port it calls at on each day.
public struct TRPCruiseOverviewModel: Codable {
    public let id: Int
    public let name: String
    public let staticRouteImage: String
    public let roundtrip: Bool
    public let manuel: Bool
    public let nights: Int
    public let departure: String
    public let arrival: String
    public let ship: TRPCruiseShipItemModel
    public let dates: [TRPCruiseOverviewDateModel]
}

/// One port call of a sailing.
public struct TRPCruiseOverviewDateModel: Codable {
    public let id: Int
    public let departure: String?
    public let arrival: String?
    public let port: TRPCruisePortItemModel
}
