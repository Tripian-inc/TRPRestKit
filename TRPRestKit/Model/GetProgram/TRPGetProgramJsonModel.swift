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
public struct TRPDailyPlans: Decodable {
    public var id: Int
    public var hash: String
    
    public var date: String
    var startTime: String?
    var endTime: String?
    public var planPois: [TRPPlanPoi]?
    
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


