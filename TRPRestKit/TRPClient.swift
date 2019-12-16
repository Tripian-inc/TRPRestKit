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
    private var apiKey = ""
    
    /// Allows link to be shown
    public var monitorUrl = false
    /// Allows Data to be shown
    public var monitorData = false
    
    private override init() {}
    
    @objc public static func start() {
        
    }
    
    public static func monitor(data: Bool? = false, url: Bool? = false) {
        TRPClient.shared.monitorUrl = url ?? false
        TRPClient.shared.monitorData = data ?? false
    }
    
    internal static func getKey() -> String {
        return TRPClient.shared.apiKey
    }
    
    /// Allows link to be shown
    ///
    /// - Parameter status: status
   /* public static func printLink(_ status: Bool) {
        TRPClient.shared.showLink = status
    } */
    
    /// Allows Data to be shown
    ///
    /// - Parameter status: status
   /* public static func printData(_ status: Bool) {
        TRPClient.shared.showData = status
    } */
}
