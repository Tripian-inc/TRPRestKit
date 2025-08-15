//
//  TRPMyTimelines.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation
internal class TRPUserTimelineServices: TRPRestServices<TRPGenericParser<[TRPTimelineModel]>> {
    
    public var limit: Int = 100
   
    private var from: String?
    private var to: String?
    
    init(from: String? = nil, to:String? = nil) {
        self.from = from
        self.to = to
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    override func parameters() -> [String: Any]? {
        var parameters = [String: Any]()
        if let from = from {
            parameters["dateFrom"] = from
        }
        if let to = to {
            parameters["dateTo"] = to
        }
        parameters["limit"] = limit
        return parameters
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.userTrips.link
    }
    
}
