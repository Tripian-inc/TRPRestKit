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
@objc public class TRPClient:NSObject {
    
    internal static var shared = TRPClient();
    private var ApiKey = "";
    
    /// Allows link to be shown
    public var showLink = false
    /// Allows Data to be shown
    public var showData = false
    
    private override init() {}
    
    
    /// An api key must be setted
    ///
    /// - Parameter key: Your api key
    @objc public static func provideApiKey(_ key: String) ->Void {
        TRPClient.shared.ApiKey = key;
    }
    
    internal static func getKey() -> String {
        return TRPClient.shared.ApiKey;
    }
    
    
    /// Allows link to be shown
    ///
    /// - Parameter status: status
    public static func printLink(_ status:Bool) -> Void {
        TRPClient.shared.showLink = status
    }
    
    /// Allows Data to be shown
    ///
    /// - Parameter status: status
    public static func printData(_ status: Bool) -> Void {
        TRPClient.shared.showData = status
    }
}
