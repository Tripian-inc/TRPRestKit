//
//  TRPRestServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 17.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// This is a high-level class to connectiong with remote server.
/// If you want to generate a new servise, new servise must be extended TRPRestServices.
public class TRPRestServices {
    
    /// A Closer. Completion handler
    public var completion:((_ result: Any?, _ error: NSError?, _ pagination: Pagination?) -> Void)?
    
    /// Sets automatic loading of Pages
    public var isAutoPagination = true
    
    /// To start connection
    public func connection() {
        let network = TRPNetwork(path: path())
        network.add(params: createParams())
        network.add(mode: requestMode())
        
        network.addValue(TRPApiKey.getApiKey(), forHTTPHeaderField: "x-api-key")
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
    
    /// To start connection using link
    ///
    /// - Parameter link: Raw link
    public func connection(link: String) {
        
        let network = TRPNetwork(link: link)
        network.addValue(TRPApiKey.getApiKey(), forHTTPHeaderField: "x-api-key")
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
    
    private func createParams() -> [String: Any] {
        var params: [String: Any] = [:]
        if let additionalParams = parameters() {
            params.merge(additionalParams, uniquingKeysWith: {(_, new) in new})
        }
        return params
    }
    
    private func bodyDataToJson(_ data: [String: Any]?) -> Data? {
        guard let bodyData = data else {
            return nil
        }
        var jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: bodyData, options: [])
        } catch let error {
            log.e("HttpBody data: \(error.localizedDescription)")
        }
        return jsonData
    }
    
    // MARK: - Overriter Funstions
    
    /// HTTP request mode
    ///
    /// - Returns: Request mode(Default is get)
    public func requestMode() -> TRPRequestMode {
        return TRPRequestMode.get
    }
    
    /// This method must be overrided to parse json
    ///
    /// - Parameters:
    ///   - data: returns from remote server
    ///   - error: nsError
    public func servicesResult(data: Data?, error: NSError?) {}
    
    /// Returns HTTP body parameters
    ///
    /// - Returns: Body params
    public func bodyParameters() -> [String: Any]? {
        return nil
    }
    
    /// Returns HTTP parameters
    ///
    /// - Returns: params
    public func parameters() -> [String: Any]? {
        return nil
    }
    
    /// Sets custom path such as /trip etc...
    ///
    /// - Returns: path
    public func path() -> String {
        return ""
    }
    
    public func paginationController(parentJson: TRPParentJsonModel) -> Pagination {
        if let nextPage = parentJson.pagination?.links?.next {
            if isAutoPagination {
                connection(link: nextPage)
            }
            return .continues(nextPage)
        } else {
            return .completed
        }
    }
    
    /// To use user oauth
    ///
    /// - Returns: bool
    public func userOAuth() -> Bool {
        return false
    }
    
    /// Returns user hash using `DataHolder`
    ///
    /// - Returns: User hash for oauth
    internal func oauth() -> String? {
        return TRPUserPersistent.fetchHashToken()
    }
    
}
