//
//  TRPTimeline.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation
internal class TRPTimelineSegmentAddUpdate: TRPRestServices<TRPGenericParser<TRPUpdatedModel>> {
    
    var segmentSetting: TRPTimelineSegmentSettings?
    
    internal override init() {}
    
    internal init(segmentSetting: TRPTimelineSegmentSettings?) {
        self.segmentSetting = segmentSetting
    }
    
    public override func path() -> String {
        var link = TRPConfig.ApiCall.timeline.link
        if let segmentSetting, let hash = segmentSetting.hash {
            link += "/\(hash)"
        }
        return link
    }
    
    override func requestMode() -> TRPRequestMode {
        return .put
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
    public override func bodyParameters() -> [String: Any]? {
        let params: [String: Any] = [:]
        
        if let segmentSetting {
            return segmentSetting.getParameters()
        }
        return params
    }
    
}
