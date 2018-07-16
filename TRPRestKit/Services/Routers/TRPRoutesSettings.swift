//
//  TRPRoutesSettings.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 10.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRoutesSettings {
    
    public var cityId: Int;
    //Incelenecek. Daha iyi nasıl yapılır bakılacak.
    public var arrivalTime: TRPTime;
    public var departureTime: TRPTime;
    public var adultsCount: Int = 1
    public var adultAgeRange: Int?;
    public var childrenCount: Int?;
    public var childrenAgeRange: Int?;
    public var coordinate: String?;
    public var answer: [Int]?;
    
    public init(cityId: Int, arrivalTime:TRPTime, departureTime:TRPTime) {
        self.cityId = cityId;
        self.arrivalTime = arrivalTime
        self.departureTime = departureTime;
    }
    
    public mutating func setCoordinate(lat:Double, lon:Double){
        coordinate = String(lat) + "," + String(lon);
    }
}
