//
//  TRPMyProgramInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 26.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

public struct TRPMyProgramInfoModel: Decodable {
    
    var id: Int
    var arrivalTime: TRPTime?
    var depatureTime: TRPTime?
    var createdTime: TRPTime?
    var city: TRPCityInfoModel?
    
    enum CodingKeys: String, CodingKey {
        case id
        case hash
        case city
        case arrivalDate = "arrival_date"
        case arrivalTime = "arrival_time"
        case departureDate = "departure_date"
        case departureTime = "departure_time"
        case createdAt = "created_at"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decode(Int.self, forKey: .id)
        let arrivalDate = try values.decode(String.self, forKey: .arrivalDate)
        let arrivalTime = try values.decode(String.self, forKey: .arrivalTime)
        let departureDate = try values.decode(String.self, forKey: .departureDate)
        let departureTime = try values.decode(String.self, forKey: .departureTime)
        
        self.arrivalTime = TRPTime(date: arrivalDate, time: arrivalTime)
        self.depatureTime = TRPTime(date: departureDate, time: departureTime)
        
        if let city = try? values.decodeIfPresent(TRPCityInfoModel.self, forKey: .city) {
            self.city = city
        }
    }
    
}
