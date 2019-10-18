//
//  TRPGetProgram.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
//fixme: - isim refactor edilecek
internal class TRPGetProgram: TRPRestServices {
    
    var hash: String?
    
    internal override init() {}
    
    internal init(hash: String) {
        self.hash = hash
    }
    
    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.completion?(nil, error, nil)
            return
        }
        guard let data = data else {
            self.completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        let jsonDecode = JSONDecoder()
        do {
            let result = try jsonDecode.decode(TRPTripJsonModel.self, from: data)
            self.completion?(result, nil, nil)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.trip.link
        if let hash = hash {
            path += "/\(hash)"
        }
        
        return path
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
}
