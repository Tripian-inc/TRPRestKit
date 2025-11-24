//
//  TRPUserPersistent.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 27.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPUserPersistent {
    
    private static let userIdCodeTag = "trpuserid"
    private static let userEmailCodeTag = "trpuseremail"
    private static let userPushTokenTag = "trpuserpushtoken"
    private static let userUUID = "trpuseruuid"

    public static var isLoggedIn: Bool {
        guard let tokens = TripianTokenController().fetchTokenInfo() else {return false}
        if !tokens.idToken.isEmpty && tokens.expiresIn != 0 {
            return true
        }
        return false
    }
    
    public static var isAnyLoggedIn: Bool {
        return isSocialLogin || isLoggedIn
    }

    public static var isTokenValid: Bool {
        return TripianTokenController().isTokenValid
    }
    
    public static var tokenInfo: TRPToken? {
        return TripianTokenController().fetchTokenInfo()
    }

    public static func getUserEmail() -> String? {
        return UserDefaults.standard.string(forKey: userEmailCodeTag)
    }
    
    public static func saveUserEmail(_ mail: String) {
        UserDefaults.standard.set(mail, forKey: userEmailCodeTag)
    }

    public static func getUserPushToken() -> String {
        return UserDefaults.standard.string(forKey: userPushTokenTag) ?? ""
    }
    
    public static func saveUserPushToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: userPushTokenTag)
    }

    public static func getUserUUID() -> String {
        if let uuid = UserDefaults.standard.string(forKey: userUUID) {
            return uuid
        }
        var uuid = ""
        if let uuidString = UIDevice.current.identifierForVendor?.uuidString {
            uuid = uuidString
        } else {
            uuid = UUID().uuidString
        }
        saveUserUUID(uuid)
        return uuid
    }
    
    public static func saveUserUUID(_ uuid: String) {
        UserDefaults.standard.set(uuid, forKey: userUUID)
    }
    
    public static var isSocialLogin: Bool {
        return TripianTokenController().isSocialLoggedIn()
    }
    
    public static func saveSocialLogin() {
        TripianTokenController().saveSocialLogin()
    }
    
    public static func remove() {
        UserDefaults.standard.removeObject(forKey: userIdCodeTag)
        UserDefaults.standard.removeObject(forKey: userEmailCodeTag)
        TripianTokenController().clearDataInUserDefaults()
    }
}
