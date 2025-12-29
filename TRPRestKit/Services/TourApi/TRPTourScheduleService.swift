//
//  TRPTourScheduleService.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

internal class TRPTourScheduleService: TRPRestServices<TRPTourScheduleJsonModel> {

    var requestModel: TRPTourScheduleRequestModel?

    internal override init() {}

    internal init(requestModel: TRPTourScheduleRequestModel) {
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
        guard let productId = requestModel?.productId else {
            return TRPConfig.ApiCall.tourSchedule.link
        }
        return TRPConfig.ApiCall.tourSchedule.link.replacingOccurrences(of: "{productId}", with: productId)
    }
}
