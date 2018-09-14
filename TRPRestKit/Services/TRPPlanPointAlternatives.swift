//
//  TRPNearbyResult.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 15.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPPlanPointAlternatives: TRPRestServices{
    
    enum NearByType {
        case nearBy
        case nearByAll
    }
    
    var hash: String?
    var planPointId: Int?
    var type:NearByType?
    
    
    public init(planPointId: Int) {
        self.planPointId = planPointId
        self.type = NearByType.nearBy
    }
    
    public init(hash: String) {
        self.hash = hash;
        self.type = NearByType.nearByAll
    }
    
    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.Completion?(nil,error, nil);
            return
        }
        guard let data = data else {
            self.Completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        let jsonDecode = JSONDecoder();
        do {
            let result = try jsonDecode.decode(TRPPlanPointAlternativeJsonModel.self, from: data)
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.PlanPointAlternative.link
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func parameters() -> Dictionary<String, Any>? {
        var params: Dictionary<String, Any> = [:]
        if let hash = hash {
            params["hash"] = hash
        }else if let planPointId = planPointId {
            params["planpoint_id"] = planPointId
        }
        return params
    }
    
}