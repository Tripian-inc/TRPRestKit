//
//  GLXAuthServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 4.04.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
final class GLXAuthServices: TRPRestServices<TRPGenericParser<TRPRefreshTokenInfoModel>> {
    
    override var mainApi: MainAPI {
        return .guestLogix
    }
    
    override func parameters() -> [String : Any]? {
        var params: [String: Any] = [:]
        /*x-device-id=B94BBEF1-C126-5DB9-864E-EBE19C1C1171&x-os-version=macOS10.14.6&x-language=en&x-locale=en-US&x-region=CA&x-application-id=com.guestlogix.Passenger&x-timezone=UTC&x-sandbox-mode=true&x-api-key=pub_4GFAvVdTBhTBgaztiBufzdStiyWDqgec_*/
        params["x-device-id"] = "B94BBEF1-C126-5DB9-864E-EBE19C1C1333"
        params["x-os-version"] = "ios13.2"
        params["x-language"] = "en"
        params["x-region"] = "US"
        params["x-application-id"] = "com.tripian.a1"
        params["x-timezone"] = "UTC"
        params["x-sandbox-mode"] = true
        params["x-api-key"] = "pub_4GFAvVdTBhTBgaztiBufzdStiyWDqgec_"
        
        return params
    }
    
    override func path() -> String {
        return TRPGlxConfig.ApiCall.auth.link
    }
}
