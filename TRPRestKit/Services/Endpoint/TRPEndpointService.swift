//
//  TRPEndpointService.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// Sends a `TRPEndpoint` and decodes the `data` of the response envelope as `T`.
internal final class TRPEndpointService<T: Decodable>: TRPRestServices<TRPGenericParser<T>> {

    private let endpoint: TRPEndpoint

    init(endpoint: TRPEndpoint) {
        self.endpoint = endpoint
    }

    override func path() -> String {
        return endpoint.path
    }

    override func requestMode() -> TRPRequestMode {
        return endpoint.mode
    }

    override func parameters() -> [String: Any]? {
        return endpoint.queryParameters
    }

    override func bodyParameters() -> [String: Any]? {
        return endpoint.bodyParameters
    }

    override func userOAuth() -> Bool {
        return endpoint.requiresAuth
    }

    override var isRefresh: Bool {
        return endpoint.isRefresh
    }
}
