//
//  TRPTags.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 20.06.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPTags: TRPRestServices{
    
    var limit = 2000
    
    internal override init() {}
    
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
            let result = try jsonDecode.decode(TRPTagsJsonModel.self, from: data)
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        let path = TRPConfig.ApiCall.Tags.link;
        return path;
    }
    
    override func parameters() -> Dictionary<String, Any>? {
        return ["limit":String(limit)]
    }
}
