//
//  TRPGetProgramDay.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPDailyPlanServices: TRPRestServices<TRPDayPlanJsonModel> {
    
    var dayId: Int?
    var startTime: String?
    var endTime: String?
    
    internal init(id: Int) {
        self.dayId = id
    }
    
    internal init(id: Int, startTime: String, endTime: String) {
        self.dayId = id
        self.startTime = startTime
        self.endTime = endTime
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    override func requestMode() -> TRPRequestMode {
        if startTime != nil && endTime != nil {
            return .put
        }
        return .get
        
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.dailyPlan.link
        if let id = dayId {
            path += "/\(id)"
        }
        
        return path
    }

    override func parameters() -> [String: Any]? {
        if let id = dayId, let startTime = startTime, let endTime = endTime {
            var params: [String: Any] = [:]
            
            params["start_time"] = startTime
            params["end_time"] = endTime
            return params
        }
        return nil
    }
}
