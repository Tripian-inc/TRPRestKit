//
//  TRPReportAProblemServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.03.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPReportAProblemServices: TRPRestServices {
    
    let categoryName: String
    var message: String?
    var poiId: Int?
    
    internal init(categoryName: String,
                           message msg: String? = nil,
                           poiId poi: Int? = nil) {
        self.categoryName = categoryName
        self.message = msg
        self.poiId = poi
    }
    
    override func servicesResult(data: Data?, error: NSError?) {
        
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
            let result = try jsonDecode.decode(TRPReportAProblemJsonModel.self, from: data)
            self.completion?(result, nil, nil)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
        
    }
    
    override func path() -> String {
        return "reportaproblem"
    }
    
    override func parameters() -> [String: Any]? {
        var params: [String: Any] = [:]
        params["problem_category"] = categoryName
        
        if let message = message {
            params["message"] = message
        }
        if let poiId = poiId {
            params["poi_id"] = poiId
        }
        return params
    }
    
    override func requestMode() -> TRPRequestMode {
        return .post
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
}
