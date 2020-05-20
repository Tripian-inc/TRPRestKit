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
            return model.accessToken
        }
        return nil
    }
    
    var refreshToken: String? {
        if let model = fetchTokenInfo() {
            return model.refreshToken
        }
        return nil
    }
    
    func saveTokenInfo(_ value: TokenInfo) {
        if let expires = calculateExpiredTime(value.expiresIn) {
            saveTokenTime(expiresIn: expires)
        }
        UserDefaults.standard.save(value, forKey: loginTokenTag)
    }
    
    func fetchTokenInfo() -> TokenInfo? {
        return UserDefaults.standard.load(type: TokenInfo.self, forKey: loginTokenTag)
    }
    
    func saveTokenTime(expiresIn: Int) {
        UserDefaults.standard.set(expiresIn, forKey: tokenExpiredTime)
    }
    
    func fetchTokenExpiredTime() -> Int? {
        return UserDefaults.standard.integer(forKey: tokenExpiredTime)
    }
    
    //Sadece debug işlemi için
    public func tokenValidUntil() {
        guard let expired = fetchTokenExpiredTime() else { return }
        
        guard let date = timeIntervalToDate(expired) else { return }
        let formatter = DateFormatter()
        formatter.timeStyle = .full
        formatter.timeZone = TimeZone(identifier: "UTC")!
    }
    
}

extension TripianTokenController {
    
    private func timeIntervalToDate(_ interval : Int) -> Date? {
        return Date(timeIntervalSince1970: TimeInterval(interval))
    }
    
    private func calculateExpiredTime(_ expiresIn: Int) -> Int? {
           guard let expiredTime = calendar.date(byAdding: .second, value: expiresIn, to: Date()) else {return nil}
           let timeInterval = Int(expiredTime.timeIntervalSince1970)
           return timeInterval
       }

}
