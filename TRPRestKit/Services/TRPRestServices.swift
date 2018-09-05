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

        if let bodyData = bodyDataToJson(bodyParameters()) {
            network.addValue("application/json", forHTTPHeaderField: "Content-Type")
            network.addValue("application/json", forHTTPHeaderField: "Accept")
            network.add(body: bodyData)
        }
        
        if userOAuth() == true {
            if let token = oauth() {
                network.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
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
    
    private func bodyDataToJson(_ data: Dictionary<String, Any>?) -> Data? {
        guard let bodyData = data else {
            return nil
        }
        var jsonData:Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: bodyData, options: [])
        }catch(let error) {
            print("HttpBody data: \(error.localizedDescription)")
        }
        return jsonData
    }
    
    
    
    // MARK: - Overriter Funstions
    
    public func requestMode() -> TRPRequestMode {
        return TRPRequestMode.get
    }
    
    public func servicesResult(data:Data?, error:NSError?) {
    }
    
    public func bodyParameters() -> Dictionary<String, Any>? {
        return nil
    }
    
    public func parameters() -> Dictionary<String, Any>? {
        return nil
    }
    
    public func path() -> String {
        return ""
    }
    
    public func paginationController(parentJson: TRPParentJsonModel, pagination: (_ status: Pagination) -> ()){
        if let nextPage = parentJson.pagination?.links?.next {
            pagination(.continuing)
            connection(link: nextPage)
        }else {
            pagination(.completed);
        }
    }
    
    public func userOAuth() -> Bool {
        return false
    }
    
    public func oauth() -> String? {
        return TRPUserPersistent.fetchHash()
    }
    
}
