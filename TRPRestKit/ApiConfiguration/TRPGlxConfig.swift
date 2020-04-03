//
//  TRPGlxConfig.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 4.04.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
internal struct TRPGlxConfig: ApiConfigurationConstant {
    
    //https://traveler.guestlogix.io/v1/auth/token?x-device-id=B94BBEF1-C126-5DB9-864E-EBE19C1C1171&x-os-version=macOS10.14.6&x-language=en&x-locale=en-US&x-region=CA&x-application-id=com.guestlogix.Passenger&x-timezone=UTC&x-sandbox-mode=true&x-api-key=pub_4GFAvVdTBhTBgaztiBufzdStiyWDqgec_
    
    var envirement: Environment {
        return TRPClient.shared.enviroment
    }
    
    var baseUrl: BaseUrlCreater {
        switch envirement {
        case .test:
            return BaseUrlCreater(baseUrl: "traveler.guestlogix.io", basePath: "v1")
        case .sandbox:
            return BaseUrlCreater(baseUrl: "traveler.guestlogix.io", basePath: "v1")
        case .production:
            return BaseUrlCreater(baseUrl: "traveler.guestlogix.io", basePath: "v1")
        }
    }
    
    internal enum ApiCall: String {
        case auth
        
        var link: String {
            switch self {
            case .auth:
                return "auth/token"
            }
        }
    }
}
