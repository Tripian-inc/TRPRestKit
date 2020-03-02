//
//  TRPFeedback.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPFeedback: TRPRestServices<TRPUserTripsJsonModel> {
    
    enum Status {
        case addFeedback
        case getAllFeedback
        case getFetchback
    }
    
    var type: Status = .getAllFeedback
    var message: String?
    var placeId: Int?
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.userTrips.link
    }
    
}
