//
//  TRPRestKit+UserCruise.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

// MARK: - User cruises
extension TRPRestKit {

    public func userCruises(completion: @escaping ResultHandler<[TRPUserCruiseModel]>) {
        send(.userCruises, completion: completion)
    }

    public func userCruise(cruiseId: Int, completion: @escaping ResultHandler<TRPUserCruiseDetailModel>) {
        send(.userCruise(cruiseId: cruiseId), completion: completion)
    }

    /// Adds a catalog cruise to the user; the backend then creates a plan for every plannable port.
    public func addUserCruise(cruiseId: Int,
                              details: TRPUserCruiseRequestModel = TRPUserCruiseRequestModel(),
                              completion: @escaping ResultHandler<TRPUserCruiseDetailModel>) {
        send(.addUserCruise(cruiseId: cruiseId, details: details), completion: completion)
    }

    /// Changes the traveller details and keeps the existing plans.
    public func editUserCruise(cruiseId: Int,
                               details: TRPUserCruiseRequestModel,
                               completion: @escaping ResultHandler<TRPUserCruiseDetailModel>) {
        send(.editUserCruise(cruiseId: cruiseId, details: details), completion: completion)
    }

    /// Changes the traveller details and creates the plans again.
    public func recreateUserCruise(cruiseId: Int,
                                   details: TRPUserCruiseRequestModel,
                                   completion: @escaping ResultHandler<TRPUserCruiseDetailModel>) {
        send(.recreateUserCruise(cruiseId: cruiseId, details: details), completion: completion)
    }

    public func deleteUserCruise(cruiseId: Int, completion: @escaping ResultHandler<TRPUpdateResultModel>) {
        send(.deleteUserCruise(cruiseId: cruiseId), completion: completion)
    }

    public func deleteUserCruisePlan(tripHash: String, completion: @escaping ResultHandler<TRPUpdateResultModel>) {
        send(.deleteUserCruisePlan(tripHash: tripHash), completion: completion)
    }
}
