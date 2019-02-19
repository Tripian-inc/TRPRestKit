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
/// You can generate this class with Builder DP.
/// ### Usage Example: ###
/// ````
/// TRPNetwork(baseUrl:"",path:"").add(params:"").add(mode: .post)
///
///
/// ````
public class TRPNetwork {
    public typealias Completion = (_ error: NSError?, _ data:Data?) -> Void
    private var baseUrl: String;
    private var path: String;
    private var params: Dictionary<String, Any>? = nil;
    private var mode: TRPRequestMode = TRPRequestMode.get;
    private var rawLink: String?;
    private var completionHandler: Completion?;
    private var bodyData: Data?
    private var headerValues: [String:String] = [:]
    
    public init(baseUrl: String,
                path: String) {
        self.baseUrl = baseUrl;
        self.path = path;
    }
    
    public convenience init(link:String) {
        self.init(baseUrl: "", path: "")
        self.rawLink = link
    }
    
    /// Config dosyasındaki BaseUrl ve BaseUrlPath i referans alır.
    /// Convenience yapıdır.
    /// - Parameter path: BaseUrl in son basamığına eklenmesi gerekn path
    convenience init(path:String) {
        self.init(baseUrl: TRPConfig.BaseUrl, path: TRPConfig.BaseUrlPath + "/" + path)
    }
    
    convenience init(rawLink:String) {
        self.init(baseUrl: "", path: "")
        self.rawLink = rawLink
    }
    
    internal func add(params: Dictionary<String, Any>) -> Void {
        self.params = params;
    }
    
    internal func add(body: Data) -> Void {
        self.bodyData = body
    }
    
    internal func addValue(_ value:String,forHTTPHeaderField:String) {
        headerValues[forHTTPHeaderField] = value
    }
    
    /// Detect connection mode like Get,Post
    /// - Default: .get
    /// - Parameter mode: Get,Post,Delete,Put
    internal func add(mode: TRPRequestMode) -> Void {
        self.mode = mode;
    }
    
    public func build(_ completion: @escaping Completion) -> Void {
        self.completionHandler = completion;
        if rawLink != nil {
            //generateSession(URL(string: rawLink!));
            var urlComponents = URLComponents(string: rawLink!)
            if let urlQueryItems = getItems(params: params) {
                urlComponents!.queryItems = urlQueryItems;
            }
            generateSession(urlComponents!.url)
        }else {
            var urlComponents = URLComponents();
            urlComponents.scheme = "https"
            urlComponents.host = baseUrl
            urlComponents.path = "/" + path
            
            if let urlQueryItems = getItems(params: params) {
                urlComponents.queryItems = urlQueryItems;
            }
            generateSession(urlComponents.url);
        }
    }
    
    public func generateSession(_ url: URL?) -> Void {
        guard let mUrl = url else {
            completionHandler?(TRPErrors.undefined as NSError,nil);
            return
        }
        if TRPClient.shared.showLink {
            print("Current URl: \(mUrl)")
        }
        let request = NSMutableURLRequest(url: mUrl);
        request.httpMethod = mode.rawValue
        
        for headerValues in headerValues {
            request.addValue(headerValues.value, forHTTPHeaderField: headerValues.key)
        }
    
        if let bodyData = bodyData {
            request.httpBody = bodyData
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            var object: Any? = nil
            
            if let data = data {
                object = try? JSONSerialization.jsonObject(with: data, options: [])
                if let strData = String(data: data, encoding: String.Encoding.utf8) {
                    if TRPClient.shared.showData  {
                        print("Request Link \(url!.absoluteString)")
                        print("Request Result \(strData)")
                    }
                }
            }
            
            if let httpResponse = response as? HTTPURLResponse  {
                //We will check httpStatus.
                if (200..<300) ~= httpResponse.statusCode {
                    guard let json = object as? JSON else {
                        self.completionHandler?(TRPErrors.wrongData as NSError,nil);
                        return
                    }
                    if let trpError = TRPErrors(json: json, link: "\(mUrl)") {
                        self.completionHandler?(trpError as NSError,nil);
                        return;
                    }
                    self.completionHandler?(nil,data);
                }else {
                    //Mistake from Server side.
                    guard let json = object as? JSON else {
                        self.completionHandler?(TRPErrors.wrongData as NSError,nil);
                        return
                    }
                    let trpError = TRPErrors(json: json, link: "\(mUrl)") ?? TRPErrors.undefined;
                    self.completionHandler?(trpError as NSError,nil);
                }
            }
            
            if let error = error as NSError? {
                self.completionHandler?(error,nil);
            }
        }
        task.resume()
    }
    
    private func getItems(params:Dictionary<String, Any>?) -> [URLQueryItem]? {
        guard let params = params else {return nil}
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            // İKİ KERE DECODE EDİLMİŞ OLUYOR.
            // Bu yüzden türkçe karakter bozulması oluyor. Kod ileride bozulmaya neden olabiir.
           /* if let mKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let mValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                queryItems.append(URLQueryItem(name: mKey, value: mValue));
            } */
            queryItems.append(URLQueryItem(name: key, value: "\(value)"));
        }
        return queryItems
    }
    
}
