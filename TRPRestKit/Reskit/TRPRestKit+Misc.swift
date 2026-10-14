//
//  TRPRestKit+Misc.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

// MARK: - Platform configuration
extension TRPRestKit {

    /// The platform configuration, including the enabled providers. Sent with the api key only, so it works before login.
    /// - Parameter platform: the platform the configuration is for, as the api names it.
    public func configList(platform: String = "ios", completion: @escaping ResultHandler<TRPConfigListModel>) {
        send(.configList(platform: platform), completion: completion)
    }
}
