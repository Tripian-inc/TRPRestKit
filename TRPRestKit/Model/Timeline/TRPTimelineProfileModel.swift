//
//  TRPGetProgramJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit
/// Indicates parameters used when creating a trip.

public struct TRPTimelineProfileModel: Decodable {
    
    /// An Int value. Id of city.
    public var cityId: Int
    /// Timeline hash value
    public var hash: String
    
    /// An Int value. Adult count.
    public var adults: Int
    /// An Int value. Count of Children
    public var children: Int?
    /// An Int value. Count of pets
    public var pets: Int?
    /// A String value. Answer of questions.You must convert to Array.
    public var answerIds = [Int]()
    
    public var doNotRecommend: [Int]?
    public var excludePoiIds: [Int]?
    public var excludeHashPois: [String]?
    public var considerWeather: Bool = false
    public var segments: [TRPTimelineSegmentModel]?
    
    private enum CodingKeys: String, CodingKey {
        case cityId
        case hash
        case adults
        case children
        case pets
        case answerIds
        case doNotRecommend
        case excludePoiIds
        case excludeHashPois
        case considerWeather
        case segments
    }
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityId = try values.decode(Int.self, forKey: .cityId)
        hash = try values.decode(String.self, forKey: .hash)
        
        adults = try values.decode(Int.self, forKey: .adults)
        children = try values.decodeIfPresent(Int.self, forKey: .children)
        pets = try values.decodeIfPresent(Int.self, forKey: .pets)
        
        self.answerIds = try values.decode([Int].self, forKey: .answerIds)
        self.doNotRecommend = try values.decodeIfPresent([Int].self, forKey: .doNotRecommend)
        self.excludePoiIds = try values.decodeIfPresent([Int].self, forKey: .excludePoiIds)
        self.excludeHashPois = try values.decodeIfPresent([String].self, forKey: .excludeHashPois)
        self.considerWeather = try values.decode(Bool.self, forKey: .considerWeather)
        self.segments = try values.decodeIfPresent([TRPTimelineSegmentModel].self, forKey: .segments)
    }

}
