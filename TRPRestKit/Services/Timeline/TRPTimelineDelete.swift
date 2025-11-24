//
//  TRPTimelineDeleteSegment.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation
internal class TRPTimelineDelete: TRPRestServices<TRPGenericParser<TRPDeleteUserTripInfo>> {
    
    /// Hash value for timeline or segment
    var hash: String
    /// Index of the segment to delete. If nil, deletes the whole timeline.
    var segmentIndex: Int?
    
    /// If segmentIndex is nil, this will delete the timeline. Otherwise, it will delete the timeline segment.    
    internal init(hash: String, segmentIndex: Int?) {
        self.hash = hash
        self.segmentIndex = segmentIndex
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.timeline.link
        path += "/\(hash)"
        
        if let segmentIndex {
            path += "/\(segmentIndex)"
        }
        
        return path
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
    override func requestMode() -> TRPRequestMode {
        return .delete
    }
    
}
