//
//  JsonParser.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 28.02.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
@testable import TRPRestKit
class JsonParser {
    
    static func parse<T: Decodable>(_ tip: T.Type, rawData: String) throws -> T {
        return try JSONDecoder().decode(tip.self, from:
            rawData.data(using: String.Encoding.utf8)!)
    }
    
}
