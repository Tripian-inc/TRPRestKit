//
//  TRPRestKit+Account.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

// MARK: - Authentication
extension TRPRestKit {

    public func login(email: String,
                      password: String,
                      device: TRPDevice = TRPDevice(),
                      completion: @escaping ResultHandler<TRPLoginInfoModel>) {
        send(.login(email: email, password: password, device: device), completion: completion)
    }

    public func refreshToken(refreshToken: String,
                             device: TRPDevice = TRPDevice(),
                             completion: @escaping ResultHandler<TRPRefreshTokenInfoModel>) {
        send(.refreshToken(refreshToken: refreshToken, device: device), completion: completion)
    }

    /// Exchanges the token of a social sign-in for a Tripian session.
    public func socialLogin(guestToken: String,
                            device: TRPDevice = TRPDevice(),
                            completion: @escaping ResultHandler<TRPSocialLoginInfoModel>) {
        send(.socialLogin(guestToken: guestToken, device: device), completion: completion)
    }

    public func loginAsGuest(firstName: String,
                             lastName: String,
                             email: String,
                             password: String,
                             device: TRPDevice = TRPDevice(),
                             completion: @escaping ResultHandler<TRPLoginInfoModel>) {
        send(.guestLogin(firstName: firstName, lastName: lastName, email: email, password: password, device: device),
             completion: completion)
    }

    public func register(firstName: String,
                         lastName: String,
                         email: String,
                         password: String,
                         device: TRPDevice = TRPDevice(),
                         completion: @escaping ResultHandler<TRPLoginInfoModel>) {
        send(.register(firstName: firstName, lastName: lastName, email: email, password: password, device: device),
             completion: completion)
    }

    public func signOut(completion: @escaping ResultHandler<TRPUpdateResultModel>) {
        send(.logout, completion: completion)
    }

    /// Sends the user an email with a link that carries the hash `resetPassword(newPassword:hash:)` needs.
    public func requestPasswordReset(email: String, completion: @escaping ResultHandler<TRPUpdateResultModel>) {
        send(.requestPasswordReset(email: email), completion: completion)
    }

    public func resetPassword(newPassword: String,
                              hash: String,
                              completion: @escaping ResultHandler<TRPResetPasswordUserModel>) {
        send(.resetPassword(password: newPassword, hash: hash), completion: completion)
    }
}

// MARK: - User
extension TRPRestKit {

    public func fetchUser(completion: @escaping ResultHandler<TRPUserInfoModel>) {
        send(.user, completion: completion)
    }

    public func updateUser(_ request: TRPUserUpdateRequestModel, completion: @escaping ResultHandler<TRPUserInfoModel>) {
        send(.updateUser(request), completion: completion)
    }

    /// - Parameter profileImage: the image as the api expects it, already encoded.
    public func updateUserImage(profileImage: String, completion: @escaping ResultHandler<TRPUserInfoModel>) {
        send(.updateUserImage(profileImage: profileImage), completion: completion)
    }

    public func deleteAccount(completion: @escaping ResultHandler<TRPUpdateResultModel>) {
        send(.deleteUser, completion: completion)
    }
}
