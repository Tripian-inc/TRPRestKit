//
//  TRPLocation.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 15.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
@objc public class TRPLocation:NSObject {
    public var lat:Double;
    public var lon:Double;
    
    init(lat:Double, lon:Double) {
        self.lat = lat;
        self.lon = lon;
    }
}
