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
    
    private override init() {}
    
    @objc public static func provideApiKey(_ key: String) ->Void {
        TRPClient.shared.ApiKey = key;
    }
    
    internal static func getKey() -> String {
        return TRPClient.shared.ApiKey;
    }
    
}
