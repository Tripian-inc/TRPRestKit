//
//  TRPProgramSteps.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPPlanPoints: TRPRestServices<TRPProgramStepJsonModel> {
    
    enum Status {
        case add
        case update
        case delete
    }
    
    var type: Status = Status.add
    var programStepId: Int?
    var hash: String?
    var dailyPlanId: Int?
    var placeId: Int?
    var order: Int?
    
    /// Add new ProgramStep
    internal init(hash: String, dailyPlanId: Int, placeId: Int, order: Int?) {
        type = Status.add
        self.hash = hash
        self.dailyPlanId = dailyPlanId
        self.placeId = placeId
        self.order = order
        type = .add
    }
    
    /// ProgramStep Get or Delete With Id
    internal init(id: Int, type: Status) {
        self.type = type
        self.programStepId = id
    }
    
    /// ProgramStep Update
    internal init(id: Int, placeId: Int?, order: Int?) {
        self.programStepId = id
        
        self.placeId = placeId
        self.order = order
        type = .update
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.dailyPlanPoi.link
        if type != .add {
            if let id = programStepId {
                path += "/\(id)"
            }
        }
        return path
    }
    
    override func requestMode() -> TRPRequestMode {
        if type == Status.add {
            return TRPRequestMode.post
        } else if type == Status.update {
            return TRPRequestMode.put
        } else if type == Status.delete {
            return TRPRequestMode.delete
        }
        return TRPRequestMode.get
    }
    
    override func parameters() -> [String: Any]? {
        var params: [String: Any] = [:]
        if type == .add {
            if let dailyPlanId = dailyPlanId,
                let placeId = placeId,
                let hash = hash {
                params["hash"] = hash
                params["dailyplan_id"] = dailyPlanId
                params["poi_id"] = placeId
                if let order = order {
                    params["order"] = order
                }
            }
        } else if type == .update {
            if programStepId == nil {
                return params
            }
            
            if let placeId = placeId {
                params["poi_id"] = placeId
            }
            if let order = order {
                params["order"] = order
            }
        }
        return params
    }
    
}
