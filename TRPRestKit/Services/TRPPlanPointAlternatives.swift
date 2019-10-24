//
//  TRPNearbyResult.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 15.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPPlanPointAlternatives: TRPRestServices {
    
    var hash: String?
    var planPointId: Int?
    var dailyPlanId: Int?
    
    public init(planPointId: Int) {
        self.planPointId = planPointId
    }
    
    public init(hash: String) {
        self.hash = hash
    }
    
    public init(dailyPlanId: Int) {
        self.dailyPlanId = dailyPlanId
    }
    
    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.completion?(nil, error, nil)
            return
        }
        guard let data = data else {
            self.completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        let jsonDecode = JSONDecoder()
        do {
            let result = try jsonDecode.decode(TRPPlanPointAlternativeJsonModel.self, from: data)
            let pag = paginationController(parentJson: result)
            self.completion?(result, nil, pag)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.planPointAlternative.link
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func parameters() -> Dictionary<String, Any>? {
        var params: Dictionary<String, Any> = [:]
        if let hash = hash {
            params["hash"] = hash
        } else if let planPointId = planPointId {
            params["planpoint_id"] = planPointId
        } else if let dailyPlanId = dailyPlanId {
            params["dailyplan_id"] = dailyPlanId
        }
        return params
    }
    
}
