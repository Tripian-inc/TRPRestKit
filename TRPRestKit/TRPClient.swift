//
//  TRPClient.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 2.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// This class provide you to start TRPRestKit.
/// Class was written with Observer Dessing pattern
///
/// - seeAlso: [Request Api Key](https://www.tripian.com/request-api-key/)
///
/// ### Usage Example: ###
///  ````
///   TRPClient.provideApiKey(#<YourApiKey>#)
///  ````
@objc public class TRPClient: NSObject {
    
    internal static var shared = TRPClient()
    
    /// Allows link to be shown
    public var monitorUrl = false
    /// Allows Data to be shown
    public var monitorData = false
    
    internal var enviroment: Environment = .test {
        didSet {
            log.i("Enviroment was changed: \(self.enviroment)")
            self.baseUrl = self.enviroment.baseUrl
        }
    }
    
    internal var baseUrl: BaseUrlCreater = Environment.test.baseUrl
    
    private override init() {}
    
    public static func start(enviroment: Environment, apiKey: String) {
        TRPClient.shared.enviroment = enviroment
        TRPApiKey.setApiKey(apiKey)
    }
    
    public static func start(baseUrl: BaseUrlCreater, apiKey: String) {
        TRPClient.shared.baseUrl = baseUrl
        TRPApiKey.setApiKey(apiKey)
    }
    
    public static func monitor(data: Bool? = false, url: Bool? = false) {
        TRPClient.shared.monitorUrl = url ?? false
        TRPClient.shared.monitorData = data ?? false
    }
    
}
