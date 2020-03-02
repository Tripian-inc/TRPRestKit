//
//  TRPGetTripService.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 2.03.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPGetTripServices: TRPRestServices<TRPGenericParser<TRPTripModel>> {
    
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
            
            let result = try jsonDecode.decode(TRPGenericParser<TRPTripModel>.self, from: data)
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




class DenemeServiceA<T: Decodable> {
    
    var parserType: T?
   
    
}
