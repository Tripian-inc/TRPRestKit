//
//  TRPTimelineModel.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation

/// Indicates information of a trip.
public struct TRPTimelineModel: Decodable {
    
    /// An Int value. Id of trip.
    public var id: Int
    /// A String value. Unique hash of trip.
    public var tripHash: String
    public var tripType: Int
    public var tripProfile: TRPTripProfileModel
    public var city: TRPCityInfoModel
    public var plans: [TRPTimelinePlansInfoModel]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case tripHash 
        case tripType
        case tripProfile
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
        self.tripType = try values.decode(Int.self, forKey: .tripType)
        self.tripProfile = try values.decode(TRPTripProfileModel.self, forKey: .tripProfile)
        self.plans = try values.decodeIfPresent([TRPTimelinePlansInfoModel].self, forKey: .plans) ?? []
        self.city = try values.decode(TRPCityInfoModel.self, forKey: .city)
    }
    
}
