//
//  TRPDevice.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 19.04.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPDevice: Decodable, Encodable {
    
    public var deviceId: String?
    public var deviceOs: String = "iOS"
    public var osVersion: String?
    public var bundleId: String?
    public var firebaseToken: String?
    
    private enum CodingKeys: String, CodingKey {
        case deviceId = "device_id"
        case deviceOs = "device_os"
        case osVersion = "os_version"
        case firebaseToken = "firebase_token"
        case bundleId = "bundle_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        self.deviceOs = try values.decodeIfPresent(String.self, forKey: .deviceOs) ?? "iOS"
        self.osVersion = try values.decodeIfPresent(String.self, forKey: .osVersion)
        self.bundleId = try values.decodeIfPresent(String.self, forKey: .bundleId)
        self.firebaseToken = try values.decodeIfPresent(String.self, forKey: .firebaseToken)
    }
    
    public init(deviceId: String,
                osVersion: String? = nil,
                bundleId: String? = nil,
                firebaseToken: String? = nil) {
        
        self.deviceId = deviceId
        self.osVersion = osVersion
        self.bundleId = bundleId
        self.firebaseToken = firebaseToken
    }
    
    public func params() -> [String: String]? {
        var params = [String: String]()
        
        params[CodingKeys.deviceId.rawValue] = deviceId
        
        params[CodingKeys.deviceOs.rawValue] = deviceOs
        
        if let osVersion = osVersion {
            params[CodingKeys.osVersion.rawValue] = osVersion
        }
        
        if let firebase = firebaseToken {
            params[CodingKeys.firebaseToken.rawValue] = firebase
        }
        
        if let bundleId = bundleId {
            params[CodingKeys.bundleId.rawValue] = bundleId
        }
        
        return params
    }
}