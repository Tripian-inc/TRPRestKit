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
    private var retryCount: Int = 0
    private let maxRetries: Int = 1

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

    public override func servicesResult(data: Data?, error: NSError?) {
        // Check for 504 Gateway Timeout error
        if let error = error, error.code == 504, retryCount < maxRetries {
            retryCount += 1
            log.w("Tour search received 504 error, retrying (\(retryCount)/\(maxRetries))...")
            connection()
            return
        }

        // Reset retry count on success or if max retries reached
        retryCount = 0
        super.servicesResult(data: data, error: error)
    }
}
