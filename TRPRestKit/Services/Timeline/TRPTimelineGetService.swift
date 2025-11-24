//
//  TRPTimelineGetService.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation

internal class TRPTimelineGetService: TRPRestServices<TRPGenericParser<TRPTimelineModel>> {
    
    var hash: String?
    
    internal override init() {}
    
    internal init(hash: String) {
        self.hash = hash
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.timeline.link
        if let hash = hash {
            path += "/\(hash)"
        }
        
        return path
    }
    
    override func parameters() -> [String : Any]? {
        var parameters = [String: Any]()
        return parameters
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
}
