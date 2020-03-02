//
//  TRPMyPrograms.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPUserTrips: TRPRestServices<TRPUserTripsJsonModel> {
    
    public var limit: Int = 50
   
    public override func userOAuth() -> Bool {
        return true
    }
    
    override func parameters() -> [String: Any]? {
        return ["limit": limit]
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.userTrips.link
    }
    
}
