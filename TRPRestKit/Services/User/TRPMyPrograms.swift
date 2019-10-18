//
//  TRPMyPrograms.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPUserTrips: TRPRestServices {
    
    public var limit: Int = 50
    
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
            let result = try jsonDecode.decode(TRPUserTripsJsonModel.self, from: data)
            self.Completion?(result, nil, nil);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    override func parameters() -> Dictionary<String, Any>? {
        return ["limit":limit]
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.userTrips.link;
    }
    
}
