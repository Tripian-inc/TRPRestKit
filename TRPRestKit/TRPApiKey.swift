//
//  TRPApiKey.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 16.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit
class TRPApiKey {
    
    internal static var shared = TRPApiKey()
    private(set) var apiKey: String?
    
    static func getApiKey() -> String {
        if TRPApiKey.shared.apiKey == nil {
           TRPApiKey.shared.apiKey = TRPApiKeyController.getKey(.trpApiKey)
        }
        
        if TRPApiKey.shared.apiKey == nil {
            log.e("Api key mustn't be empty. Please add your api key in Info.Plist file.")
        }
        
        return TRPApiKey.shared.apiKey ?? ""
    }
    
    static func setApiKey(_ key: String) {
        TRPApiKey.shared.apiKey = key
    }
    
}
