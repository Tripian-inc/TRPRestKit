//
//  TokenController.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.04.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
class TripianTokenController: TokenControllerProtocol {
    
    private var calendar: Calendar {
        var currentCalendar = Calendar.current
        if let timeZone = TimeZone(identifier: "UTC") {
            currentCalendar.timeZone = timeZone
        }
        return currentCalendar
    }
    
    var loginTokenTag: String { return "trpLoginTokenModel" }
    
    var tokenExpiredTime: String { return "trpTokenStartTime" }
    
    var isTokenValid: Bool {
        guard let expired = fetchTokenExpiredTime() else {
            return false
        }
        return expired > Int(Date().timeIntervalSince1970)
    }
    
    var token: String? {
        if let model = fetchTokenInfo() {
            return model.idToken
        }
        return nil
    }
    
    var refreshToken: String? {
        if let model = fetchTokenInfo() {
            return model.refreshToken
        }
        return nil
    }
    
    func saveTokenInfo(_ value: TRPToken) {
        if let expires = calculateExpiredTime(value.expiresIn) {
            saveTokenTime(expiresIn: expires)
        }
        UserDefaults.standard.save(value, forKey: loginTokenTag)
    }
    
    func fetchTokenInfo() -> TRPToken? {
        return UserDefaults.standard.load(type: TRPToken.self, forKey: loginTokenTag)
    }
    
    func saveTokenTime(expiresIn: Int) {
        UserDefaults.standard.set(expiresIn, forKey: tokenExpiredTime)
    }
    
    func fetchTokenExpiredTime() -> Int? {
        return UserDefaults.standard.integer(forKey: tokenExpiredTime)
    }
    
    func clearDataInUserDefaults() {
        UserDefaults.standard.removeObject(forKey: loginTokenTag)
        UserDefaults.standard.removeObject(forKey: tokenExpiredTime)
    }
    
}

extension TripianTokenController {
    
    private func calculateExpiredTime(_ expiresIn: Int) -> Int? {
           guard let expiredTime = calendar.date(byAdding: .second, value: expiresIn, to: Date()) else {return nil}
           let timeInterval = Int(expiredTime.timeIntervalSince1970)
           return timeInterval
       }

}
