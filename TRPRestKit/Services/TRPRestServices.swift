//
//  TRPRestServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 17.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPRestServices {
    
    public var Completion:((_ result:Any?, _ error:NSError?, _ pagination: Pagination?) -> Void)?
    
    public func connection() {
        let network = TRPNetwork(path: path());
        network.add(params: createParams())
        network.add(mode: requestMode())
        network.build { (error, data) in
            self.servicesResult(data: data, error: error)
        }
    }
    
    public func connection(link:String) {
        let network = TRPNetwork(rawLink: link)
        network.build { (error, data) in
            self.servicesResult(data: data, error: error)
        }
    }
    
    private func createParams() -> Dictionary<String, Any> {
        var params : Dictionary<String, Any> = ["api_key":TRPClient.getKey()];
        if let additionalParams = parameters() {
            params.merge(additionalParams, uniquingKeysWith: {(old, new) in new});
        }
        return params
    }
    
    // MARK: - Overriter Funstions
    
    public func requestMode() -> TRPRequestMode {
        return TRPRequestMode.get
    }
    
    public func servicesResult(data:Data?, error:NSError?) {
        
    }
    
    public func parameters() -> Dictionary<String, Any>? {
        return nil
    }
    
    public func path() -> String {
        return ""
    }
    
    public func paginationController(parentJson: TRPParentJsonModel, pagination: (_ status: Pagination) -> ()){
        if let nextPage = parentJson.meta?.pagination?.links?.next {
            pagination(.continuing)
            connection(link: nextPage)
        }else {
            pagination(.completed);
        }
    }
}
