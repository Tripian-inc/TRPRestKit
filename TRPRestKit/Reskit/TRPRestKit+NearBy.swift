//
//  TRPRestKit+NearBy.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation
import TRPFoundationKit

// MARK: - NearBy Services
extension TRPRestKit {
    
    /// Obtain plan poi alternative list with given trip hash and completion parameters.
    ///
    /// - Parameters:
    ///    - withHash: A String value that refers to foretold trip hash.
    ///    - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPPlanPointAlternativeInfoModel]** object.
    public func stepAlternatives(withHash hash: String, completion: @escaping CompletionHandler) {
        completionHandler = completion
        planPointAlternative(hash: hash)
    }
    
    /// Obtain plan poi alternative list with given trip hash and completion parameters.
    ///
    /// - Parameters:
    ///    - withDailyPlanId: An Integer that refers to Id of the daily plan.
    ///    - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Important: Completion Handler is an any object which needs to be converted to **[TRPPlanPointAlternativeInfoModel]** object.
    public func stepAlternatives(withPlanId id: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        planPointAlternative(planId: id)
    }
    
    public func stepAlternatives(stepId id: Int, completion: @escaping CompletionHandler) {
        completionHandler = completion
        planPointAlternative(stepId: id)
    }
    
    /// A services which will be used in plan poi alternative services, manages all task connecting to remote server.
    private func planPointAlternative(hash: String? = nil, stepId: Int? = nil, planId: Int? = nil) {
        var poiAlternativeService: TRPStepAlternativesServices?
        
        if let hash = hash {
            poiAlternativeService = TRPStepAlternativesServices(hash: hash)
        }else if let stepId = stepId {
            poiAlternativeService = TRPStepAlternativesServices(stepId: stepId)
        }else if let planId = planId {
            poiAlternativeService = TRPStepAlternativesServices(planId: planId)
        }
        
        guard let service = poiAlternativeService else {return}
        
        service.completion = { (result, error, pagination) in
            if let error = error {
                self.postError(error: error)
                return
            }
            if let serviceResult = result as? TRPPlanPointAlternativeJsonModel, let data = serviceResult.data {
                self.postData(result: data, pagination: pagination)
                return
            }
            self.postError(error: TRPErrors.emptyDataOrParserError as NSError)
        }
        service.connection()
    }
    
}

