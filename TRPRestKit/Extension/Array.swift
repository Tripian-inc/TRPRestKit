//
//  Array.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
extension Array {
    public func toString() -> String {
        let arrayToString = self.map{"\($0)"}
        return arrayToString.joined(separator: ",")
    }
}
