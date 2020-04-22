//
//  TRPUserPersistent.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 27.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPUserPersistent {
    
    private static var calendar: Calendar {
        var currentCalendar = Calendar.current
        if let timeZone = TimeZone(identifier: "UTC") {
            currentCalendar.timeZone = timeZone
        }
        return currentCalendar
    }
    
    private static let userIdCodeTag = "trpuserid"
    private static let userEmailCodeTag = "trpuseremail"
    private static let loginTokenTag = "trpLoginTokenModel"
    
    private static let tokenExpiredTimeTag = "trpTokenStartTime"
    
    public static func token() -> String? {
        return fetchLoginToken()?.accessToken
    }
    
    public static func didUserLoging() -> Bool {
        return fetchLoginToken() == nil ? false : true
    }
    
    public static var isTokenValid: Bool {
        guard let expired = fetchTokenExpiredTime() else {
            return false
        }
        return expired > Int(Date().timeIntervalSince1970)
    }
    
    public static func tokenValidUntil() -> String? {
        guard let expired = fetchTokenExpiredTime() else {
            return nil
        }
        
        guard let date = timeIntervalToDate(expired) else {
            return nil
        }
    
        let formatter = DateFormatter()
        formatter.timeStyle = .full
        formatter.timeZone = TimeZone(identifier: "UTC")!
        print("TOKEN VALİD UNTİL \(formatter.string(from: date))")
        return formatter.string(from: date)
    }
    
    public static func fetchId() -> Int? {
        return UserDefaults.standard.integer(forKey: userIdCodeTag)
    }
    
    public static func saveId(_ value: Int) {
        UserDefaults.standard.set(value, forKey: userIdCodeTag)
    }
    
    public static func getUserEmail() -> String? {
        return UserDefaults.standard.string(forKey: userEmailCodeTag)
    }
    
    public static func saveUserEmail(_ mail: String) {
        UserDefaults.standard.set(mail, forKey: userEmailCodeTag)
    }
    
    public static func remove() {
        UserDefaults.standard.removeObject(forKey: userIdCodeTag)
        UserDefaults.standard.removeObject(forKey: loginTokenTag)
        UserDefaults.standard.removeObject(forKey: userEmailCodeTag)
    }
}

// MARK: Login
extension TRPUserPersistent {
    
    internal static func saveLoginToken(_ model: TRPLoginTokenInfoModel) {
        if let expiresTime = calculateExpiredTime(model.expiresIn) {
            saveTokenTimes(expiresIn: expiresTime)
        }else {
            print("[FatalError] Token expires time can not calculated")
        }
        
        UserDefaults.standard.save(model, forKey: loginTokenTag)
    }
    
    internal static func fetchLoginToken() -> TRPLoginTokenInfoModel? {
        return UserDefaults.standard.load(type: TRPLoginTokenInfoModel.self, forKey: loginTokenTag)
    }
}

//MARK: - Token Expired Time
extension TRPUserPersistent {
    
    /// Token ın başlagıç zamanını kaydeder
    private static func saveTokenTimes(expiresIn: Int) {
        UserDefaults.standard.set(expiresIn, forKey: tokenExpiredTimeTag)
    }
    
    private static func fetchTokenExpiredTime() -> Int? {
        return UserDefaults.standard.integer(forKey: tokenExpiredTimeTag)
    }
    
    private static func calculateExpiredTime(_ expiresIn: Int) -> Int? {
        guard let expiredTime = calendar.date(byAdding: .second, value: expiresIn, to: Date()) else {return nil}
        let timeInterval = Int(expiredTime.timeIntervalSince1970)
        print("Expired Time \(expiredTime) - \(timeInterval) - now: \(Date())")
        return timeInterval
    }
    
    private static func timeIntervalToDate(_ interval : Int) -> Date? {
        return Date(timeIntervalSince1970: TimeInterval(interval))
    }
}
