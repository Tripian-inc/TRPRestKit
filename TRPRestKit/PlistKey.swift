//
//  PlistKey.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 12.12.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public enum PlistKey {
    case ServerUrl
    case userName
    
    func value()-> String {
        switch self {
        case .ServerUrl:
            return "m_server_url"
        case .userName:
            return "m_user_name"
        }
    }
    
}


public struct Environment {
    
    fileprivate var infoDict: [String:Any] {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file didn't find")
            }
        }
    }
    
    public func configuration(_ key: PlistKey) -> String {
        return infoDict[key.value()] as! String
    }
    
}
