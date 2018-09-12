//
//  TRPTripInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 12.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPTripInfoModel: Decodable{
    var id: Int
    var hash: String?
    var arrivalTime: TRPTime?
    var depatureTime: TRPTime?
    var params: TRPGetProgramParamsInfoModel?
    var days: [TRPGetProgramDayInfoModel]?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case hash
        case arrivalDate = "arrival_date"
        case arrivalTime = "arrival_time"
        case departureDate = "departure_date"
        case departureTime = "departure_time"
        case params
        case days
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decode(Int.self, forKey: .id)
        self.hash = try values.decodeIfPresent(String.self, forKey: .hash) ?? ""
        let arrivalDate = try values.decode(String.self, forKey: .arrivalDate)
        let arrivalTime = try values.decode(String.self, forKey: .arrivalTime)
        let departureDate = try values.decode(String.self, forKey: .departureDate)
        let departureTime = try values.decode(String.self, forKey: .departureTime)
        
        self.arrivalTime = TRPTime(date: arrivalDate, time: arrivalTime)
        self.depatureTime = TRPTime(date: departureDate, time: departureTime)
        
        if let programParams = try? values.decodeIfPresent(TRPGetProgramParamsInfoModel.self, forKey: .params) {
            self.params = programParams
        }
        
        if let days = try? values.decodeIfPresent([TRPGetProgramDayInfoModel].self, forKey: .days) {
            self.days = days
        }
        //        if let city = try? values.decodeIfPresent(TRPCityInfoModel.self, forKey: .city) {
        //            self.city = city
        //        }
    }
}
