//
//  TRPTourSearch.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

internal class TRPTourSearchService: TRPRestServices<TRPTourSearchJsonModel> {

    var requestModel: TRPTourSearchRequestModel?

    internal override init() {}

    internal init(requestModel: TRPTourSearchRequestModel) {
        self.requestModel = requestModel
    }

    override func userOAuth() -> Bool {
        return true
    }

    override func requestMode() -> TRPRequestMode {
        return .post
    }

    override func bodyParameters() -> [String: Any]? {
        return requestModel?.toDictionary()
    }

    public override func path() -> String {
        return TRPConfig.ApiCall.tourSearch.link
    }
}
