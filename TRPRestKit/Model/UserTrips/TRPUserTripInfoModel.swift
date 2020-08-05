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
    
    /// An Int value. Id of trip.
    public var id: Int
    
    /// A String value. Unique hash of trip.
    public var tripHash: String
    
    public var tripProfile: TRPTripProfileModel
    public var city: TRPCityInfoModel
    
    private enum CodingKeys: String, CodingKey {
        case id
        case tripHash = "trip_hash"
        case tripProfile = "trip_profile"
        case city
    }
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.tripHash = try values.decode(String.self, forKey: .tripHash)
        self.tripProfile = try values.decode(TRPTripProfileModel.self, forKey: .tripProfile)
        self.city = try values.decode(TRPCityInfoModel.self, forKey: .city)
    }
    
}
