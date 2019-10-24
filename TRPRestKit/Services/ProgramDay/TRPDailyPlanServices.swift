//
//  TRPGetProgramDay.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPDailyPlanServices: TRPRestServices {
    
    var dayId:Int?
    var startTime: String?
    var endTime: String?
    
    internal init(id:Int) {
        self.dayId = id
    }
    
    internal init(id: Int, startTime:String, endTime: String) {
        self.dayId = id
        self.startTime = startTime
        self.endTime = endTime
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
            let result = try jsonDecode.decode(TRPDayPlanJsonModel.self, from: data)
            self.Completion?(result, nil, nil);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
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
        var path = TRPConfig.ApiCall.dailyPlan.link;
        if let id = dayId {
            path += "/\(id)"
        }
        
        return path
    }

    override func parameters() -> Dictionary<String, Any>? {
        if let id = dayId, let startTime = startTime, let endTime = endTime {
            var params : Dictionary<String, Any> = [:];
            
            params["start_time"] = startTime
            params["end_time"] = endTime
            return params
        }
        return nil
    }
}
