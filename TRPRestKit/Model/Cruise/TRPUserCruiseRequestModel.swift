//
//  TRPUserCruiseRequestModel.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// The traveller details sent when a cruise is added to the user, edited or recreated.
/// A nil value is left out of the request.
public struct TRPUserCruiseRequestModel {

    public var hasPreTour: Int?
    public var hasPostTour: Int?
    public var numberOfAdults: Int?
    public var numberOfChildren: Int?
    public var companionIds: [Int]?

    public init(hasPreTour: Int? = nil,
                hasPostTour: Int? = nil,
                numberOfAdults: Int? = nil,
                numberOfChildren: Int? = nil,
                companionIds: [Int]? = nil) {
        self.hasPreTour = hasPreTour
        self.hasPostTour = hasPostTour
        self.numberOfAdults = numberOfAdults
        self.numberOfChildren = numberOfChildren
        self.companionIds = companionIds
    }

    internal func toDictionary() -> [String: Any] {
        var params = [String: Any]()
        params["hasPreTour"] = hasPreTour
        params["hasPostTour"] = hasPostTour
        params["numberOfAdults"] = numberOfAdults
        params["numberOfChildren"] = numberOfChildren
        params["companionIds"] = companionIds
        return params
    }
}
