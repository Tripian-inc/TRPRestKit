//
//  TRPRestKit+Tour.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Tour Search Services
extension TRPRestKit {

    /// Search for tour products using a request model
    ///
    /// - Parameters:
    ///   - request: Tour search request model containing all search parameters
    ///   - completion: Completion handler with tour products array
    public func searchTours(
        request: TRPTourSearchRequestModel,
        completion: @escaping CompletionHandler
    ) {
        self.completionHandler = completion
        tourSearchServices(request: request)
    }

    private func tourSearchServices(request: TRPTourSearchRequestModel) {
        let service = TRPTourSearchService(requestModel: request)

        service.completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPTourSearchJsonModel {
                if let searchData = serviceResult.data {
                    self.postData(result: searchData, pagination: pagination)
                    return
                }
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }

        service.connection()
    }
}
