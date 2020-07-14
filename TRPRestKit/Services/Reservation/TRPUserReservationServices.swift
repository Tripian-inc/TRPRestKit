//
//  TRPUserReservationServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 14.07.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPUserReservationServices: TRPRestServices<TRPGenericParser<TRPReactionModel>> {
    
    var cityId: Int?
    var tripHash: String?
    var poiId: Int?
    var from: String?
    var to: String?
    var provider: String?
    var limit: Int?
    
    
    
    public override func path() -> String {
        let url = TRPConfig.ApiCall.userReservation.link
        
        return url
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
    override func requestMode() -> TRPRequestMode {
        return .get
    }
    
    override func bodyParameters() -> [String: Any]? {
        
        var params = [String: Any]()
        if let poiId = poiId {
            params["poi_id"] = poiId
        }
       
        return params
    }
}
