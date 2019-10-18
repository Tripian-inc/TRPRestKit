//
//  TRPMyProgramInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 26.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// Indicates information about trip to listin.
/// This model can be used in `MyTip`
public struct TRPUserTripInfoModel: Decodable {
    
    /// An Int value. Id of a trip.
    public var id: Int
    /// A TRPTime object. Arrival time of trip.
    public var arrivalTime: TRPTime?
    /// A TRPTime object. Departure time of trip.
    public var depatureTime: TRPTime?
    /// A TRPCityInfoModel object. The city where the trip is.
    public var city: TRPCityInfoModel?
    /// A String value. Unique hash of trip.
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
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
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
