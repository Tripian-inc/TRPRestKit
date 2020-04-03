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
public class TRPRestServices<T: Decodable> {
    
    typealias JsonParserModel = T
    
    /// A Closer. Completion handler
    public var completion:((_ result: Any?, _ error: NSError?, _ pagination: Pagination?) -> Void)?
    
    /// Sets automatic loading of Pages
    public var isAutoPagination = true
    
    /// To start connection
    public func connection(_ url: String? = nil) {
        var network: TRPNetwork?
        //Fonksiyondan alınacak
        if let url = url {
            network = TRPNetwork(link: url)
        }else {
          //  network = TRPNetwork(path: path())
            network = TRPNetwork(component: createPath(api: mainApi, path: path()))
            network!.add(params: createParams())
            network!.add(mode: requestMode())
        }
        
        guard let networkService = network else {return}
        //Fonksiyondan alınacak
        //networkService.addValue(TRPApiKey.getApiKey(), forHTTPHeaderField: "x-api-key")
        networkService.addValue("application/json", forHTTPHeaderField: "Content-Type")
        networkService.addValue("application/json", forHTTPHeaderField: "Accept")
        
        for aBC in parameters() ?? [:] {
                networkService.addValue("\(aBC.value)", forHTTPHeaderField: aBC.key)
            }
        
        if let bodyData = bodyDataToJson(bodyParameters()) {
            
            networkService.add(body: bodyData)
        }
        if userOAuth() == true {
            if let token = oauth() {
                //networkService.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
        networkService.build { (error, data) in
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
    
    var isPagination: Bool {
        return false
    }
    
    public var mainApi: MainAPI {
        return .tripian
    }
    
    private func createPath(api: MainAPI, path: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = api.configuration.baseUrl.baseUrl
        components.path = "/" + api.configuration.baseUrl.basePath + "/" + path
        return components
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
    public func servicesResult(data: Data?, error: NSError?) {
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
            let result = try jsonDecode.decode(JsonParserModel.self, from: data)
            let pagination = checkPagination(result)
            self.completion?(result, nil, pagination)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }
    
    private func checkPagination(_ result: Decodable) -> Pagination? {
        guard let parent = result as? TRPParentJsonModel else {return nil}
        return paginationController(parentJson: parent)
    }
    
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
    
    public func paginationController(parentJson: TRPParentJsonModel) -> Pagination? {
        guard let pagination = parentJson.pagination else {
            return nil
        }
        if let nextPage = pagination.links?.next {
            if isAutoPagination {
                connection(nextPage)
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
