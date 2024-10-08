//
//  TRPUserDeleteServices.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 1.09.2022.
//  Copyright © 2022 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPUserDeleteServices: TRPRestServices<TRPParentJsonModel> {
    
    public override func path() -> String {
        return TRPConfig.ApiCall.user.link
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
    override func requestMode() -> TRPRequestMode {
        return .delete
    }
}
