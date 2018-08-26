//
//  TRPProgramSettings.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPProgramSettings {
    
    public var cityId: Int;
    //Incelenecek. Daha iyi nasıl yapılır bakılacak.
    public var arrivalTime: TRPTime;
    public var departureTime: TRPTime;
    public var adultsCount: Int = 1
    public var adultAgeRange: String?;
    public var childrenCount: Int?;
    public var childrenAgeRange: String?;
    public var coordinate: String?;
    public var hotelAddress: String?
    public var answer: [Int]?;
    public var doNotGenerate:Bool?
    
    public init(cityId: Int, arrivalTime:TRPTime, departureTime:TRPTime) {
        self.cityId = cityId;
        self.arrivalTime = arrivalTime
        self.departureTime = departureTime;
    }
    
    public mutating func setCoordinate(lat:Double, lon:Double){
        coordinate = String(lat) + "," + String(lon);
    }
}

