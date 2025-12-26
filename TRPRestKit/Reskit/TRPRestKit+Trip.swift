//
//  TRPRestKit+Trip.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Trip
extension TRPRestKit {
    
    /// Create a trip with given settings and completion handler parameters.
    ///
    /// Values and meanings of generate attribute in of dayplans; 0=not generated yet, 1=generated and recommended, -1=generated but not recommended.
    ///
    /// - Parameters:
    ///   - settings: TRPTripSettings object that includes settings for the trip.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPTripInfoModel** object. You can only generate trips for next two years.
    public func createTrip(settings: TRPTripSettings, completion: @escaping CompletionHandler) {
        completionHandler = completion
        if let city = settings.cityId, city != 0 {
            createOrEditTripServices(settings: settings)
        }else {
            print("[Error] City Id hash must not be empty")
        }
    }
    
    /// Update trip with given settings and completion handler parameters.
    ///
    /// - Parameters:
    ///   - settings: TRPTripSettings object that includes settings for the updating trip.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPTripInfoModel** object. You can only generate trips for next two years.
    public func editTrip(settings: TRPTripSettings, completion: @escaping CompletionHandler) {
        completionHandler = completion
        if let hash = settings.hash, !hash.isEmpty {
            createOrEditTripServices(settings: settings)
        }else {
            print("[Error] Trip hash must not be empty")
        }
    }
    
    /// A services which will be used for both creating and editing services, manages all task connecting to remote server.
    private func createOrEditTripServices(settings: TRPTripSettings) {
        let programService = TRPProgram(setting: settings)
        programService.completion = { result, error, pagination in
            self.genericParseAndPost(TRPTripModel.self, result, error, pagination)
        }
        programService.connection()
    }
    
    /// Get trip info with given trip hash and completion handler parameters.
    ///
    /// - Parameters:
    ///   - hash: A String value that refers to trip hash.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPTripModel** object.
    public func getTrip(withHash hash: String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        getTripServices(hash: hash)
    }
    
    /// A services which will be used forgetting trip info services, manages all task connecting to remote server.
    private func getTripServices(hash: String) {
        
        let getProgramService = TRPGetTripServices(hash: hash)
        getProgramService.completion = { result, error, pagination in
            self.genericParseAndPost(TRPTripModel.self, result, error, pagination)
        }
        getProgramService.connection()
    }
    
    /// Delete trip info with given trip hash and completion handler parameters.
    ///
    /// - Parameters:
    ///   - hash: A String value that refers to foretold deleting trip hash.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPParentJsonModel** object.
    public func deleteTrip(hash: String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        deleteTripServices(hash: hash)
    }
    
    /// A services which will be used in delete trip services, manages all task connecting to remote server.
    private func deleteTripServices(hash: String) {
        let deleteService = TRPDeleteProgram(hash: hash)
        deleteService.completion = { result, error, pagination in
            self.genericParseAndPost(TRPDeleteUserTripInfo.self, result, error, pagination)
        }
        deleteService.connection()
    }
    
}

