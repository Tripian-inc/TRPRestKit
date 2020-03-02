//
//  TRPNearbyResult.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 15.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPPlanPointAlternatives: TRPRestServices<TRPPlanPointAlternativeJsonModel> {
    
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
    
    public override func path() -> String {
        return TRPConfig.ApiCall.planPointAlternative.link
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func parameters() -> [String: Any]? {
        var params: [String: Any] = [:]
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
