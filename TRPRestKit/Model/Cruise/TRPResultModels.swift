//
//  TRPResultModels.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// The answer to a call that changes or removes something.
public struct TRPUpdateResultModel: Codable {
    public let updated: Bool?
}

/// The answer to a call that creates something.
public struct TRPCreateResultModel: Codable {
    public let recordId: String?
}

/// The user whose password was reset.
public struct TRPResetPasswordUserModel: Codable {
    public let id: Int
    public let firstName: String
    public let lastName: String
    public let email: String
}
