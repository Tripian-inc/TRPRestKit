//
//  TRPTripInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 12.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// Indicates information of a trip.
public struct TRPTripInfoModel: Decodable {
    
    /// An Int value. Id of trip.
    public var id: Int
    /// A String value. Unique hash of trip.
    public var tripHash: String
    /// A TRPTime object. Arrival time of trip.
    public var arrivalTime: TRPTime?
    /// A TRPTime object. Departure time of trip.
    public var depatureTime: TRPTime?
    /// A TRPGetProgramParamsInfoModel object. All parameters sent to create a trip.
    public var params: TRPGetProgramParamsInfoModel?
    /// Array of TRPDailyPlanInfoModel object. Includes information of one day such as date, poi etc...
    public var dailyPlans: [TRPDailyPlanInfoModel]?
    /// A TRPCityInfoModel objects.
    public var city: TRPCityInfoModel
    
    private enum CodingKeys: String, CodingKey {
        case id
        case tripHash = "trip_hash"
        case arrivalDate = "arrival_date"
        case arrivalTime = "arrival_time"
        case departureDate = "departure_date"
        case departureTime = "departure_time"
        case params
        case dailyplans
        case city
    }
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.hash = try values.decode(String.self, forKey: .hash)
        
        if let days = try? values.decodeIfPresent([TRPDailyPlanInfoModel].self, forKey: .dailyplans) {
            self.dailyPlans = days
        }
        
        let arrivalDate = try values.decode(String.self, forKey: .arrivalDate)
        let arrivalTime = try values.decode(String.self, forKey: .arrivalTime)
        let departureDate = try values.decode(String.self, forKey: .departureDate)
        let departureTime = try values.decode(String.self, forKey: .departureTime)
        
        self.arrivalTime = TRPTime(date: arrivalDate, time: arrivalTime)
        self.depatureTime = TRPTime(date: departureDate, time: departureTime)
        
        city = try values.decode(TRPCityInfoModel.self, forKey: .city)
        
        if let programParams = try? values.decodeIfPresent(TRPGetProgramParamsInfoModel.self, forKey: .params) {
            self.params = programParams
        }
    }
    
}
