//
//  TRPTimeline.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation
internal class TRPTimeline: TRPRestServices<TRPGenericParser<TRPTimelineModel>> {
    
    var setting: TRPTimelineSettings?
    var segmentSetting: TRPTimelineSegmentSettings?
    
    internal override init() {}
    
    internal init(setting: TRPTimelineSettings?, segmentSetting: TRPTimelineSegmentSettings?) {
        self.setting = setting
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
        if let segmentSetting {
            return .put
        }
        return .post
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
    public override func bodyParameters() -> [String: Any]? {
        var params: [String: Any] = [:]
        
        if let setting = setting {
            return setting.getParameters()
        }
        
        if let segmentSetting {
            return segmentSetting.getParameters()
        }
        return params
    }
    
}
