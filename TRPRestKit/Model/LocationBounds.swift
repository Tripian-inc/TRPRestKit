//
//  LocationBounds.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 16.06.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit
public struct LocationBounds {
    public var northWest: TRPLocation
    public var southEast: TRPLocation
    
    public init(northWest: TRPLocation, southEast: TRPLocation) {
        self.northWest = northWest
        self.southEast = southEast
    }
}
