//
//  TRPNearbyResult.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 15.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPNearBy: TRPRestServices{
    
    enum NearByType {
        case nearBy
        case nearByAll
    }
    
    var hash: String?
    var programStepId: Int?
    var type:NearByType?
    
    
    public init(programStepId: Int) {
        self.programStepId = programStepId
        self.type = NearByType.nearBy
    }
    
    public init(hash: String) {
        self.hash = hash;
        self.type = NearByType.nearByAll
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
            let result = try jsonDecode.decode(TRPNearByJsonModel.self, from: data)
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        if type == NearByType.nearBy {
            if let stepId = programStepId {
                return TRPConfig.ApiCall.Nearby.link + "/\(stepId)"
            }
        }else if type == NearByType.nearByAll {
            if let hash = hash {
                return TRPConfig.ApiCall.NearbyAll.link + "/\(hash)"
            }
        }
        return TRPConfig.ApiCall.Nearby.link
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
}
