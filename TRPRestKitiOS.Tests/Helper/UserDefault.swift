//
//  UserDefault.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 13.03.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
@propertyWrapper
struct Storage<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
