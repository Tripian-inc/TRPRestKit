//
//  TRPTripInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 12.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

// TODO: - DAİLY PLANS EKLENECEK
public struct TRPTripInfoModel: Decodable{
    public var id: Int
    public var hash: String
    public var arrivalTime: TRPTime?
    public var depatureTime: TRPTime?
    public var params: TRPGetProgramParamsInfoModel?
    public var dailyPlans: [TRPDailyPlanInfoModel]?
    public var city: TRPCityInfoModel
    
    private enum CodingKeys: String, CodingKey {
        case id
        case hash
        case arrivalDate = "arrival_date"
        case arrivalTime = "arrival_time"
        case departureDate = "departure_date"
        case departureTime = "departure_time"
        case params
        case dailyplans
        case city
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
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
