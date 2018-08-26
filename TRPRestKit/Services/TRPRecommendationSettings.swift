//
//  TRPRecommendationSettings.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 9.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRecommendationSettings {
    
    public var cityId: Int;
    public var typeId: [Int]?;
    public var adultsCount: Int?
    public var adultAgeRange: String?
    public var childrenCount: Int?
    public var childrenAgeRange: String?
    public var currentCoordinate: String?;
    public var answer: [Int]?;
    
    
    public init(cityId:Int) {
        self.cityId = cityId;
    }
    
    public mutating func currentCoordinate(lat:Double, lon:Double){
        currentCoordinate = String(lat) + "," + String(lon);
    }
}
