//
//  TRPGetProgramDay.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPDailyPlanServices: TRPRestServices {
    
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
            let result = try jsonDecode.decode(TRPDayPlanJsonModel.self, from: data)
            self.completion?(result, nil, nil)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
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
        var path = TRPConfig.ApiCall.dailyPlan.link
        if let dId = dayId {
            path += "/\(dId)"
        }
        
        return path
    }

    override func parameters() -> [String: Any]? {
        if let startTime = startTime, let endTime = endTime {
            var params = [String: Any]()
            params["start_time"] = startTime
            params["end_time"] = endTime
            return params
        }
        return nil
    }
}
