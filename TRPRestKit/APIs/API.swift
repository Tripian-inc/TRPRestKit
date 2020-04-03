//
//  API.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 3.04.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public enum MainAPI {
    case tripian, guestLogix
    
    var configuration: ApiConfigurationConstant {
        switch self {
        case .tripian:
            return TRPConfig()
        case .guestLogix:
            return TRPConfig()
        }
    }
}
