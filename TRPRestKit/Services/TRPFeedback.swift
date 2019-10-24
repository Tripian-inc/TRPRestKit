//
//  TRPFeedback.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPFeedback: TRPRestServices {
    
    enum Status {
        case addFeedback
        case getAllFeedback
        case getFetchback
    }
    
    var type: Status = .getAllFeedback
    var message: String?
    var placeId: Int?
    
//    internal init(setting: TRPProgramSettings) {
//        self.setting = setting
//    }
//    
//    internal init(placeId:Int, ) {
//        self.type = .getAllFeedback
//    }
    
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
            let result = try jsonDecode.decode(TRPUserTripsJsonModel.self, from: data)
            self.completion?(result, nil, nil)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.userTrips.link
    }
    
}
