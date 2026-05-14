//
//  TRPTourProductLookup.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

internal class TRPTourProductLookupService: TRPRestServices<TRPTourProductLookupJsonModel> {

    var requestModel: TRPTourProductLookupRequestModel?

    internal override init() {}

    internal init(requestModel: TRPTourProductLookupRequestModel) {
        self.requestModel = requestModel
    }

    override func userOAuth() -> Bool {
        return false
    }

    override func requestMode() -> TRPRequestMode {
        return .post
    }

    override func bodyParameters() -> [String: Any]? {
        return requestModel?.toDictionary()
    }

    public override func path() -> String {
        return TRPConfig.ApiCall.tourProductLookup.link
    }
}
