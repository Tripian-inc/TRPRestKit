//
//  TRPConstantsServices.swift
//  TRPRestKit
//
//  Created by Rozeri Dağtekin on 7/30/19.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPConstantsServices: TRPRestServices {
    
    internal override init() {}
    
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
            let result = try jsonDecode.decode(TRPConstantsParentJsonModel.self, from: data)
            self.completion?(result, nil, nil)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
        
    }
    
    override func path() -> String {
        return "sdk-constants"
    }
    
    override func parameters() -> Dictionary<String, Any>? {
        var params: Dictionary<String, Any> = [:]
        params["platform"] = "ios"
        return params
    }
    override func userOAuth() -> Bool {
        return true
    }
    
}
