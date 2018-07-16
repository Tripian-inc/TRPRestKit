//
//  TRPRoutesResult.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 10.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPRoutesResult: TRPRestServices{
    
    var hash: String;
    
    internal init(hash: String) {
        self.hash = hash;
    }
    
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
            let result = try jsonDecode.decode(TRPRoutesResultJsonModel.self, from: data)
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.RoutesResult.link;
    }
    
    public override func parameters() -> Dictionary<String, Any>? {
        return ["hash":hash];
    }
    
}
