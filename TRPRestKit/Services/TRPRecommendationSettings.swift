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
    public var rating: Int?;
    public var distance: Int?;
    public var popularity: Int?;
    public var currentCoordinate: String?;
    public var answer: [Int]?;
    //Result places count - Max value 200.Default 15;
    public var limit: Int?;
    
    public var paginationLimit: Int?
    
    public init(cityId:Int) {
        self.cityId = cityId;
    }
    
    public mutating func currentCoordinate(lat:Double, lon:Double){
        currentCoordinate = String(lat) + "," + String(lon);
    }
}
