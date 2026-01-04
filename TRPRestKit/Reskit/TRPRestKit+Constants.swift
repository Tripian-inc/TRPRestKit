//
//  TRPRestKit+Constants.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Constants
extension TRPRestKit {
    
    /// Obtain the list of constants that are used in Tripian Mobile Apps such as required max day between trips.
    ///
    /// - Parameters:
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    public func getConstants(completion: @escaping CompletionHandler) {
        completionHandler = completion
        constantServices()
    }
    
    /// A services which will be used in constant services, manages all task connecting to remote server.
    private func constantServices() {
        let constantsService = TRPConstantsServices()
        constantsService.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceReuslt = result as? TRPConstantsParentJsonModel {
                self.postData(result: serviceReuslt.data?.constants)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        constantsService.connection()
    }
    
}

// MARK: - Version
extension TRPRestKit {
    
    /// Obtain the list of versions that are used in Tripian Mobile Apps such as required min frameworks.
    ///
    /// - Parameters:
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    public func getVersion(completion: @escaping CompletionHandler) {
        completionHandler = completion
        versionServices()
    }
    
    /// A services which will be used in version services, manages all task connecting to remote server.
    private func versionServices() {
        let constantsService = TRPConstantsServices()
        constantsService.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPConstantsParentJsonModel {
                self.postData(result: serviceResult.data?.version)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        constantsService.connection()
    }
    
}

