//
//  TRPUserPersistent.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 27.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPUserPersistent {
    
    private static let userHashCodeTag = "trpuserhash"
    private static let userIdCodeTag = "trpuserid"
    private static let userEmailCodeTag = "trpuseremail"
    
    public static func didUserLoging() -> Bool {
        return fetchHash() == nil ? false : true
    }
    
    
    public static func fetchHash() -> String? {
        return UserDefaults.standard.string(forKey: userHashCodeTag)
    }
    
    public static func saveHash(_ value: String) {
        UserDefaults.standard.set(value, forKey: userHashCodeTag)
    }
    
    public static func fetchId() -> Int? {
        return UserDefaults.standard.integer(forKey: userIdCodeTag)
    }
    
    public static func saveId(_ value: Int) {
        UserDefaults.standard.set(value, forKey: userIdCodeTag)
    }
    
    public static func getUserEmail(_ mail: String) -> String?{
        return UserDefaults.standard.string(forKey: userEmailCodeTag)
    }
    
    public static func saveUserEmail(_ mail: String) {
        UserDefaults.standard.set(mail, forKey: userEmailCodeTag)
    }
    
    public static func remove() {
        UserDefaults.standard.removeObject(forKey: userIdCodeTag)
        UserDefaults.standard.removeObject(forKey: userHashCodeTag)
    }
}
