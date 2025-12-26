//
//  TRPRestKit+Problem.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Problem Categories
extension TRPRestKit {
    
    /// Obtain problem categories, such as incorrect location, incorrect name etc..., with completion handler parameter.
    ///
    /// - Parameters:
    ///    - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPProblemCategoriesInfoModel]** object.
    public func problemCategories(completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        problemCategoriesService()
    }
    
    /// A services which will be used in problem categories services, manages all task connecting to remote server.
    private func problemCategoriesService() {
        let categoryService = TRPProblemCategories()
        categoryService.completion = { (result, error, _) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPProblemCategoriesJsonModel {
                self.postData(result: serviceResult.datas)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        categoryService.connection()
    }
    
}

// MARK: - Report A problem
extension TRPRestKit {
    
    /// Obtain problem categories, such as incorrect location, incorrect name etc..., with completion handler parameter.
    ///
    /// - Parameters:
    ///    - category: A String value which refers to the category name of the place.
    ///    - message: A String value which refers to the message for the problem of the place.
    ///    - poiId: A String value which refers to the id of the given place.
    ///    - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPReportAProblemInfoModel** object.
    public func reportaProblem(category name: String,
                               message msg: String?,
                               poiId poi: String?,
                               completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        reportaProblemService(categoryName: name, message: msg, poiId: poi)
    }
    
    /// A services which will be used in report a problem services, manages all task connecting to remote server.
    private func reportaProblemService(categoryName: String, message: String?, poiId: String?) {
        let reportAProblemService = TRPReportAProblemServices(categoryName: categoryName,
                                                              message: message,
                                                              poiId: poiId)
        reportAProblemService.completion = { result, error, _ in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPReportAProblemJsonModel {
                self.postData(result: serviceResult.data ?? nil)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        reportAProblemService.connection()
    }
}

