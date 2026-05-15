//
//  TRPTourScheduleAvailabilityService.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

internal class TRPTourScheduleAvailabilityService: TRPRestServices<TRPTourScheduleAvailabilityJsonModel> {

    var requestModel: TRPTourScheduleAvailabilityRequestModel?

    internal override init() {}

    internal init(requestModel: TRPTourScheduleAvailabilityRequestModel) {
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
        return TRPConfig.ApiCall.tourScheduleAvailability.link
    }
}
