//
//  TRPUserUpdateRequestModel.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// The profile fields to change. A nil or empty value is left untouched on the server,
/// and the device's time zone is always sent along.
public struct TRPUserUpdateRequestModel {

    public var firstName: String?
    public var lastName: String?
    public var password: String?
    public var currentPassword: String?
    public var dateOfBirth: String?
    public var answers: [Int]?

    public init(firstName: String? = nil,
                lastName: String? = nil,
                password: String? = nil,
                currentPassword: String? = nil,
                dateOfBirth: String? = nil,
                answers: [Int]? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.currentPassword = currentPassword
        self.dateOfBirth = dateOfBirth
        self.answers = answers
    }

    internal func toDictionary() -> [String: Any] {
        var params = [String: Any]()
        let texts = ["firstName": firstName,
                     "lastName": lastName,
                     "password": password,
                     "currentPassword": currentPassword,
                     "dateOfBirth": dateOfBirth]
        for (key, value) in texts {
            if let value = value, !value.isEmpty {
                params[key] = value
            }
        }
        params["answers"] = answers
        params["timezone"] = TimeZone.current.identifier
        return params
    }
}
