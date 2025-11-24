//
//  TRPTimelineGetService.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation

internal class TRPTimelinePlanGetService: TRPRestServices<TRPGenericParser<[TRPTimelinePlansInfoModel]>> {
    
    var planId: String?
    
    internal override init() {}
    
    internal init(planId: String) {
        self.planId = planId
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.timeline.link
        if let planId = planId {
            path += "/segment/\(planId)"
        }
        
        return path
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
}
