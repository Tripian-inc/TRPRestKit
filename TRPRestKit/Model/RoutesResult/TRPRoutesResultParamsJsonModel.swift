//
//  TRPRoutesResultParamsJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRoutesResultParamsJsonModel: Decodable {
    
    var cityId: String?;
    var arrivalDate: String?;
    var departureDate: String?;
    var arrivalTime:String?;
    var departureTime: String?;
    var apiKey: String?;
    var adults: String?;
    var hash: String?;
    
    enum CodingKeys: String, CodingKey {
        case cityId = "city_id";
        case arrivalDate = "arrival_date";
        case departureDate = "departure_date";
        case arrivalTime = "arrival_time";
        case departureTime = "departure_time";
        case adults
        case hash
        case apiKey = "api_key"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        cityId = try values.decodeIfPresent(String.self, forKey: .cityId);
        arrivalDate = try values.decodeIfPresent(String.self, forKey: .arrivalDate);
        departureDate = try values.decodeIfPresent(String.self, forKey: .departureDate);
        arrivalTime = try values.decodeIfPresent(String.self, forKey: .arrivalTime);
        departureTime = try values.decodeIfPresent(String.self, forKey: .departureTime);
        adults = try values.decodeIfPresent(String.self, forKey: .adults);
        hash = try values.decodeIfPresent(String.self, forKey: .hash);
        apiKey = try values.decodeIfPresent(String.self, forKey: .apiKey);
    }
    
}
