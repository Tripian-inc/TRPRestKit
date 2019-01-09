//
//  Plist.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 13.12.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public enum PlistKey {
    case ServerURL
    case ConfigName
    case ServerPath
    
    func value() -> String {
        switch self {
        case .ServerURL:
            return "trp_server_url"
        case .ServerPath:
            return "trp_server_path"
        case .ConfigName:
            return "trp_config_name"
        }
    }
}

public class Environment {
    
    public init() {}
    
    fileprivate  var frameworkInfoDict: [String: Any]  {
        get {
            let fmBundle = Bundle(for: type(of: self))
            if let dict = fmBundle.infoDictionary {
                return dict
            }else {
                fatalError("Plist file didn't found in TRPRestKit")
            }
        }
    }
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .ServerURL:
            return frameworkInfoDict[PlistKey.ServerURL.value()] as! String
        case .ServerPath:
            return frameworkInfoDict[PlistKey.ServerPath.value()] as! String
        case .ConfigName:
            return frameworkInfoDict[PlistKey.ConfigName.value()] as! String
        }
    }
}
