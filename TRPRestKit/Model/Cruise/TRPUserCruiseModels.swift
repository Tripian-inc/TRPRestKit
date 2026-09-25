//
//  TRPUserCruiseModels.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// A cruise the user has added, as listed.
public struct TRPUserCruiseModel: Codable {
    public var id: Int
    public var name: String
    public var departure: String
    public var arrival: String
    public var hasPreTour: Bool
    public var hasPostTour: Bool
    public var ship: TRPUserCruiseShipModel
    public var brand: TRPUserCruiseBrandModel
    /// True when the sailing changed after the user added it and the plans should be recreated.
    public var updateRequired: Bool

    public init(id: Int,
                name: String,
                departure: String,
                arrival: String,
                hasPreTour: Bool,
                hasPostTour: Bool,
                ship: TRPUserCruiseShipModel,
                brand: TRPUserCruiseBrandModel,
                updateRequired: Bool) {
        self.id = id
        self.name = name
        self.departure = departure
        self.arrival = arrival
        self.hasPreTour = hasPreTour
        self.hasPostTour = hasPostTour
        self.ship = ship
        self.brand = brand
        self.updateRequired = updateRequired
    }
}

/// A cruise the user has added, with its days.
public struct TRPUserCruiseDetailModel: Codable {
    public var id: Int
    public var name: String?
    public var departure: String?
    public var arrival: String?
    public var staticRouteImage: String?
    public var ship: TRPUserCruiseShipModel?
    public var brand: TRPUserCruiseBrandModel?
    public var preTour: TRPUserCruiseDayModel?
    public var postTour: TRPUserCruiseDayModel?
    public var days: [TRPUserCruiseDayModel]?
}

public struct TRPUserCruiseShipModel: Codable {
    public var id: Int
    public var name: String
    public var image: String
    public var specifications: TRPShipSpecificationsModel?

    public init(id: Int, name: String, image: String, specifications: TRPShipSpecificationsModel? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.specifications = specifications
    }
}

public struct TRPShipSpecificationsModel: Codable {
    public var passengers: String
    public var crew: String
    public var cabins: String
    public var length: String
    public var decksWithCabins: String
    public var yearOfBuild: String
}

public struct TRPUserCruiseBrandModel: Codable {
    public var id: Int
    public var name: String
    public var logo: String

    public init(id: Int, name: String, logo: String) {
        self.id = id
        self.name = name
        self.logo = logo
    }
}

/// A day of the user's cruise: a port call, or the stay before or after the sailing.
public struct TRPUserCruiseDayModel: Codable {
    public var portId: Int
    public var portName: String?
    public var departure: String?
    public var arrival: String?
    /// The hash of the day's plan, nil until one is created.
    public var tripianHash: String?
    public var trip: Bool?
    public var cityId: Int?
    public var cityImage: String?
    public var tripianHashVersion: String?
    public var bookablePoi: Bool?
    public var cityDisplayName: String?
}
