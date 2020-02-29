//
//  TRPTripInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 12.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// Indicates information of a trip.
public struct TRPTripInfoModel111: Decodable {
    
    /// An Int value. Id of trip.
    public var id: Int
    /// A String value. Unique hash of trip.
    public var tripHash: String

    public var tripProfile: TRPCreateTripParamsModel
    
    private enum CodingKeys: String, CodingKey {
        case id
        case tripHash = "trip_hash"
        case tripProfile = "trip_profile"
        case city
        case plans
        
    }
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.tripHash = try values.decode(String.self, forKey: .tripHash)
        self.tripProfile = try values.decode(TRPCreateTripParamsModel.self, forKey: .tripProfile)
        
        
        
        TRPPlansInfoModel
        /*
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
        }*/
    }
    
}
