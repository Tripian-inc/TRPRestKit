//
//  TRPErrorModel.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 30.06.2025.
//  Copyright © 2025 Evren Yaşar. All rights reserved.
//

import Foundation

class TRPErrorModel: NSError, @unchecked Sendable {
    private var isAuthError: Bool = false
    
    public func setAuthError(_ isAuthError: Bool) {
        self.isAuthError = isAuthError
    }
    
    public func isAuthenticationError() -> Bool {
        return isAuthError
    }
}
