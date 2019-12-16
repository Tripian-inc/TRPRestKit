//
//  TRPNetwork.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 2.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
typealias JSON = [String: Any]
/// Provide connection remote server.
/// This class is use NSURLRequest.
public class TRPNetwork {
    
    /// A typealias value. Completion handler.
    public typealias Completion = (_ error: NSError?, _ data: Data?) -> Void
    private var baseUrl: String
    private var path: String
    private var params: [String: Any]?
    private var mode: TRPRequestMode = TRPRequestMode.get
    private var rawLink: String?
    private var completionHandler: Completion?
    private var bodyData: Data?
    private var headerValues: [String: String] = [:]
    
    /// Initializes a new object with baseURL and path.
    ///
    /// - Parameters:
    ///   - baseUrl: Remote server base url
    ///   - path: path
    public init(baseUrl: String,
                path: String) {
        self.baseUrl = baseUrl
        self.path = path
    }
    
    /// Initializes a new object with link.
    ///
    /// - Parameter link: url
    public convenience init(link: String) {
        self.init(baseUrl: "", path: "")
        self.rawLink = link
    }
    
    /// Initializes a new object with path.
    /// Base url is taken from TRPConfig classes.
    /// - Parameter link: url
    convenience init(path: String) {
        self.init(baseUrl: TRPConfig.getBaseUrl(), path: TRPConfig.getBaseUrlPath() + "/" + path)
    }
    
    internal func add(params: [String: Any]) {
        self.params = params
    }
    
    internal func add(body: Data) {
        self.bodyData = body
    }
    
    internal func addValue(_ value: String, forHTTPHeaderField: String) {
        headerValues[forHTTPHeaderField] = value
    }
    
    /// Detect connection mode like Get,Post
    /// - Default: .get
    /// - Parameter mode: Get,Post,Delete,Put
    internal func add(mode: TRPRequestMode) {
        self.mode = mode
    }
    
    /// To start connection with server
    ///
    /// - Parameter completion: Completion handler
    public func build(_ completion: @escaping Completion) {
        self.completionHandler = completion
        let urlComponents = createComponents(url: rawLink)
        
        guard let url = urlComponents.url else {
            completionHandler?(TRPErrors.undefined as NSError, nil)
            return
        }
        if TRPClient.shared.monitorUrl {
            log.i("CurrentUrl: \(url)")
        }
        generateSession(url)
    }
    
    private func createComponents(url: String?) -> URLComponents {
        var urlComponents: URLComponents?
        if let url = url {
            urlComponents = URLComponents(string: url)
        }
        if urlComponents == nil {
            urlComponents = URLComponents()
            urlComponents!.scheme = "https"
            urlComponents!.host = baseUrl
            urlComponents!.path = "/" + path
        }
        if let urlQueryItems = getItems(params: params) {
            urlComponents!.queryItems = urlQueryItems
        }
        return urlComponents!
    }
    
    /// To start connection with server using Url
    ///
    /// - Parameter completion: Completion handler
    public func generateSession(_ url: URL) {
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = mode.rawValue
        
        for headerValues in headerValues {
            request.addValue(headerValues.value, forHTTPHeaderField: headerValues.key)
        }
        
        if let bodyData = bodyData {
            request.httpBody = bodyData
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            var object: Any?
            
            if let data = data {
                object = try? JSONSerialization.jsonObject(with: data, options: [])
                self.logger(data: data, url: url)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                //We will check httpStatus.
                if (200..<300) ~= httpResponse.statusCode {
                    guard let json = object as? JSON else {
                        self.completionHandler?(TRPErrors.wrongData as NSError, nil)
                        return
                    }
                    if let trpError = TRPErrors(json: json, link: "\(url)") {
                        self.completionHandler?(trpError as NSError, nil)
                        return
                    }
                    self.completionHandler?(nil, data)
                } else {
                    //Mistake from Server side.
                    guard let json = object as? JSON else {
                        self.completionHandler?(TRPErrors.wrongData as NSError, nil)
                        return
                    }
                    let trpError = TRPErrors(json: json, link: "\(url)") ?? TRPErrors.undefined
                    self.completionHandler?(trpError as NSError, nil)
                }
            }
            
            if let error = error as NSError? {
                self.completionHandler?(error, nil)
            }
        }
        task.resume()
    }
    
    private func getItems(params: [String: Any]?) -> [URLQueryItem]? {
        guard let params = params else {return nil}
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            // İKİ KERE DECODE EDİLMİŞ OLUYOR.
            // Bu yüzden türkçe karakter bozulması oluyor. Kod ileride bozulmaya neden olabiir.
            /* if let mKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
             let mValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
             queryItems.append(URLQueryItem(name: mKey, value: mValue));
             } */
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        return queryItems
    }
    
    private func logger(data: Data, url: URL) {
        if !TRPClient.shared.monitorData {return}
        guard let strData = String(data: data, encoding: String.Encoding.utf8) else {return}
        log.i("Request Result: \(strData)")
    }
}
