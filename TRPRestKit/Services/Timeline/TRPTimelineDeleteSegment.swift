//
//  TRPTimelineDeleteSegment.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation
internal class TRPTimelineDeleteSegment: TRPRestServices<TRPGenericParser<TRPDeleteTimelineSegmentModel>> {
    
    var hash: String?
    var segmentIndex: Int?
    
    internal override init() {}
    
    internal init(hash: String, segmentIndex: Int) {
        self.hash = hash
        self.segmentIndex = segmentIndex
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.timeline.link
        if let hash = hash {
            path += "/\(hash)"
        }
        
        return path
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
    override func requestMode() -> TRPRequestMode {
        return .delete
    }
    
    override func bodyParameters() -> [String : Any]? {
        var params = [String: Any]()
        params["segmentIndex"] = segmentIndex
        return params
    }
    
}
