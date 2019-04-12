//
//  TRPMyProgramInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 26.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPUserTripInfoModel: Decodable {
    
    public var id: Int
    public var arrivalTime: TRPTime?
    public var depatureTime: TRPTime?
    public var city: TRPCityInfoModel?
    public var hash: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case hash
        case city
        case arrivalDate = "arrival_date"
        case arrivalTime = "arrival_time"
        case departureDate = "departure_date"
        case departureTime = "departure_time"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decode(Int.self, forKey: .id)
        self.hash = try values.decode(String.self, forKey: .hash)
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
