//
//  TRPAddUserReservationServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 15.07.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPAddUserReservationServices: TRPRestServices<TRPGenericParser<TRPReservationInfoModel>> {
    
    private(set) var key: String
    private(set) var provider: String
    var tripHash: String?
    var poiId: Int?
    var value: [String: Any]?
    
    init(key: String, provider: String, tripHash: String? = nil, poiId: Int? = nil, value: [String: Any]? = nil) {
        self.key = key
        self.provider = provider
        self.tripHash = tripHash
        self.poiId = poiId
        self.value = value
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.userReservation.link
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
    override func requestMode() -> TRPRequestMode {
        return .post
    }
    
    override func bodyParameters() -> [String: Any]? {
        var params = [String: Any]()
        params["key"] = key
        params["provider"] = provider
        
        if let tripHash = tripHash {
            params["trip_hash"] = tripHash
        }
        
        if let poiId = poiId {
            params["poi_id"] = poiId
        }
        
        if let value = value {
            params["value"] = value
        }
        return params
    }
    
}
