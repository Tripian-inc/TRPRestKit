//
//  TRPRestKit+Tour.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Tour Services
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

    /// Get tour schedule for a specific product
    ///
    /// - Parameters:
    ///   - request: Tour schedule request model containing productId, date, and optional parameters
    ///   - completion: Completion handler with tour schedule data
    public func getTourSchedule(
        request: TRPTourScheduleRequestModel,
        completion: @escaping CompletionHandler
    ) {
        self.completionHandler = completion
        tourScheduleServices(request: request)
    }

    private func tourScheduleServices(request: TRPTourScheduleRequestModel) {
        let service = TRPTourScheduleService(requestModel: request)

        service.completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPTourScheduleJsonModel {
                if let scheduleData = serviceResult.data {
                    self.postData(result: scheduleData, pagination: pagination)
                    return
                }
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }

        service.connection()
    }

    /// Look up a single tour product by provider + product ID
    ///
    /// - Parameters:
    ///   - request: Tour product lookup request model (providerId + productId)
    ///   - completion: Completion handler returning a TRPTourProductInfoModel
    public func lookupTourProduct(
        request: TRPTourProductLookupRequestModel,
        completion: @escaping CompletionHandler
    ) {
        self.completionHandler = completion
        tourProductLookupServices(request: request)
    }

    private func tourProductLookupServices(request: TRPTourProductLookupRequestModel) {
        let service = TRPTourProductLookupService(requestModel: request)

        service.completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPTourProductLookupJsonModel {
                if let product = serviceResult.data {
                    self.postData(result: product, pagination: pagination)
                    return
                }
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }

        service.connection()
    }

    /// Check schedule availability for a list of activities on a given date
    ///
    /// - Parameters:
    ///   - request: Tour schedule availability request model (items + date + optional currency/lang)
    ///   - completion: Completion handler returning a `TRPTourScheduleAvailabilityDataModel`
    public func getTourScheduleAvailability(
        request: TRPTourScheduleAvailabilityRequestModel,
        completion: @escaping CompletionHandler
    ) {
        self.completionHandler = completion
        tourScheduleAvailabilityServices(request: request)
    }

    private func tourScheduleAvailabilityServices(request: TRPTourScheduleAvailabilityRequestModel) {
        let service = TRPTourScheduleAvailabilityService(requestModel: request)

        service.completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPTourScheduleAvailabilityJsonModel {
                if let availabilityData = serviceResult.data {
                    self.postData(result: availabilityData, pagination: pagination)
                    return
                }
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }

        service.connection()
    }
}
