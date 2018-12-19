//
//  TRPClient.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 2.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
@objc public class TRPClient:NSObject {
    
    internal static var shared = TRPClient();
    private var ApiKey = "";
    public var showLink = false
    public var showData = false
    
    private override init() {}
    
    @objc public static func provideApiKey(_ key: String) ->Void {
        TRPClient.shared.ApiKey = key;
    }
    
    internal static func getKey() -> String {
        return TRPClient.shared.ApiKey;
    }
    
    public static func printLink(_ status:Bool) -> Void {
        TRPClient.shared.showLink = status
    }
    
    public static func printData(_ status: Bool) -> Void {
        TRPClient.shared.showData = status
    }
}
