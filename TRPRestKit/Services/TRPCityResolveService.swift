//
//  TRPCityResolveService.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 29.01.2026.
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

internal class TRPCityResolveService: TRPRestServices<TRPGenericParser<[TRPCityResolveInfoModel]>> {

    private var requestItems: [[String: Any]]

    init(requestItems: [[String: Any]]) {
        self.requestItems = requestItems
    }

    override func requestMode() -> TRPRequestMode {
        return .post
    }

    override func path() -> String {
        return TRPConfig.ApiCall.cityResolve.link
    }

    override func userOAuth() -> Bool {
        return true
    }

    override func bodyRawData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: requestItems, options: [])
    }
}
