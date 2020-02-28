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
public struct TRPGetProgramParamsInfoModel: Decodable {
    
    /// An Int value. Id of city.
    public var cityId: String?
    /// A String value. Arrival date of trip.
    public var arrivalDateTime: String?
    /// A String value. Departure date of trip.
    public var departureDateTime: String?
    
    /// An Int value. Adult count.
    public var numberOfAdults: Int?
    /// An Int value. Count of Children
    public var numberOfChildren: Int?
    public var startCoordinate: TRPLocation?
    /// A String value. Address of hotel.
    public var accommodation_address: String?
    
    /// A String value. Answer of questions.You must convert to Array.
    public var answers = [Int]()
    /// A String value. Companion of users for the selected trip.You must convert to Array.
    public var companionIds = [Int]()
    public var tripAnswers = [Int]()
    public var owner: String?
    public var doNotGenerate: Int
    
    
    
    private enum CodingKeys: String, CodingKey {
        case cityId = "city_id"
        case arrivalDateTime = "arrival_datetime"
        case departureDateTime = "departure_datetime"
        case numberOfAdults = "number_of_adults"
        case numberOfChildren = "number_of_children"
        case owner
        case answers
        case tripAnswers
        case companionIds = "companion_ids"
        case pace
        case accommodationAddress = "accommodation_address"
        case doNotGenerate = "do_not_generate"
    }
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityId = try values.decodeIfPresent(String.self, forKey: .cityId)
        arrivalDateTime = try values.decodeIfPresent(String.self, forKey: .arrivalDateTime)
        departureDateTime = try values.decodeIfPresent(String.self, forKey: .departureDateTime)
        
        numberOfAdults = try values.decode(Int.self, forKey: .numberOfAdults)
        numberOfChildren = try values.decodeIfPresent(Int.self,forKey: .numberOfChildren)
        
        
        self.coordinate = try values.decodeIfPresent(String.self, forKey: .coordinate)
        
        self.hotelAddress = try values.decodeIfPresent(String.self, forKey: .hotelAddress)
        
        if let answersStr = try values.decodeIfPresent(String.self, forKey: .answers) {
            answers = answersStr.toIntArray()
        }
        
        if let tripAnswersStr = try values.decodeIfPresent(String.self, forKey: .tripAnswers) {
            tripAnswers = tripAnswersStr.toIntArray()
        }
        
        if let companionsStr = try values.decodeIfPresent(String.self, forKey: .companions) {
            companions = companionsStr.toIntArray()
        }
        
    }

}
