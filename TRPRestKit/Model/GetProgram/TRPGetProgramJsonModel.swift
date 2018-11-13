//
//  TRPGetProgramJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPGetProgramParamsInfoModel: Decodable {
    
    
    var cityId: String?;
    var arrivalDate: String?;
    var departureDate: String?;
    var arrivalTime:String?;
    var departureTime: String?;
    var adults: Int?;
    var adultAgeRange: String?
    var children: Int?
    var childrenAgeRange: String?
    var coord: String?
    var answers: String?
    var hotelAddress: String?
    
    
    
    enum CodingKeys: String, CodingKey {
        case cityId = "city_id";
        case arrivalDate = "arrival_date";
        case departureDate = "departure_date";
        case arrivalTime = "arrival_time";
        case departureTime = "departure_time";
        case adults
        
        case adultAgeRange = "adult_age_range"
        case children
        case childAgeRange = "children_age_range"
        case coord
        case answer
        case hotelAddress = "hotel_address"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        cityId = try values.decodeIfPresent(String.self, forKey: .cityId);
        arrivalDate = try values.decodeIfPresent(String.self, forKey: .arrivalDate);
        departureDate = try values.decodeIfPresent(String.self, forKey: .departureDate);
        arrivalTime = try values.decodeIfPresent(String.self, forKey: .arrivalTime);
        departureTime = try values.decodeIfPresent(String.self, forKey: .departureTime);
        
        if let adults = try values.decodeIfPresent(String.self, forKey: .adults), let adultsCount = Int(adults) {
            self.adults = adultsCount
        }
        
        if let children = try values.decodeIfPresent(String.self, forKey: .children), let childrenCount = Int(children) {
            self.children = childrenCount
        }
        
        self.adultAgeRange = try values.decodeIfPresent(String.self, forKey: .adultAgeRange)
        self.childrenAgeRange = try values.decodeIfPresent(String.self, forKey: .childAgeRange)
        self.coord = try values.decodeIfPresent(String.self, forKey: .coord)
        self.answers = try values.decodeIfPresent(String.self, forKey: .answer)
        self.hotelAddress = try values.decodeIfPresent(String.self, forKey: .hotelAddress)
        
        
    }

}

// TODO: - REFACTOR EDİLECEK.

/*
 "id": 11705,
 "hash": "dac35e8551c58aad0a634680a902d9bd652206d4814cb94e06c73625932c01f7",
 "date": "2018-11-12",
 "start_time": "09:00",
 "end_time": "21:00",
 "dailyplanpoi": [{
 "id": 108722,
 "order": 0,
 "poi_id": 20589
 }, {
 "id": 108723,
 "order": 1,
 "poi_id": 43428
 }, {
 "id": 108724,
 "order": 2,
 "poi_id": 29107
 }, {
 "id": 108725,
 "order": 3,
 "poi_id": 21795
 }, {
 "id": 108726,
 "order": 4,
 "poi_id": 43843
 }, {
 "id": 108727,
 "order": 5,
 "poi_id": 44473
 }, {
 "id": 108728,
 "order": 6,
 "poi_id": 28734
 }]
 
 */


public struct TRPDailyPlans: Decodable {
    var id: Int
    var hash: String
    
    var date: String
    var startTime: String?
    var endTime: String?
    var planPois: [TRPPlanPoi]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case hash
        case date
        case startTime = "start_time"
        case endTime = "end_time"
        case dailyPlanPoi = "dailyplanpoi"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        id = try values.decode(Int.self, forKey: .id)
        hash = try values.decode(String.self, forKey: .hash);
        date = try values.decode(String.self, forKey: .date);
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime);
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime);
    
        if let pois = try? values.decode([TRPPlanPoi].self, forKey: .dailyPlanPoi) {
            self.planPois = pois
        }
    }
}


