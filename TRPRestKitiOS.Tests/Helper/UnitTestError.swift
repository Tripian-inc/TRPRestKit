//
//  UnitTestError.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 6.03.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
enum UnitTestError: Error {
    case typeCasting
    case trpError(_ error: String)
    case unDefined
}
