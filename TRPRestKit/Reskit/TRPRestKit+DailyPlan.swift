//
//  TRPRestKit+DailyPlan.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - Daily Plan
extension TRPRestKit {
    
    /// Obtain daily plan with given daily plan id, and completion parameters.
    ///
    /// Values and meanings of generate attribute in of dayplans; 0=not generated yet, 1=generated and recommended, -1=generated but not recommended.
    ///
    /// - Parameters:
    ///   - id: An Integer value that refers to id of the daily plan.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **TRPDailyPlanInfoModel** object.
    public func dailyPlan(id: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        dailyPlanServices(id: id)
    }
    
    /// A services which will be used in daily plan services, manages all task connecting to remote server.
    private func dailyPlanServices(id: Int) {
        let dailyPlanServices = TRPDailyPlanServices(id: id)
        dailyPlanServices.completion = {   (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPDayPlanJsonModel {
                self.postData(result: serviceResult.data)
            }else {
                self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
            }
        }
        dailyPlanServices.connection()
    }
    
}

