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
//TODO:- adı değiştirilecek //TRİP PRofile
public struct TRPTripProfileModel: Decodable {
    
    /// An Int value. Id of city.
    public var cityId: Int
    /// A String value. Arrival date of trip.
    public var arrivalDateTime: String?
    /// A String value. Departure date of trip.
    public var departureDateTime: String?
    
    /// An Int value. Adult count.
    public var numberOfAdults: Int
    /// An Int value. Count of Children
    public var numberOfChildren: Int?
    /// A String value. Answer of questions.You must convert to Array.
    public var answers = [Int]()
    public var tripAnswers = [Int]()
    public var owner: String?
    public var startCoordinate: TRPCoordinateModel?
    
    /// A String value. Address of hotel.
    public var accommodationAddress: String?
    /// A String value. Companion of users for the selected trip.You must convert to Array.
    public var companionIds = [Int]()
    //TODO: - Pace Enum haline getirilecek
    public var pace: String?

    public var doNotGenerate: Int
    
    private enum CodingKeys: String, CodingKey {
        case cityId = "city_id"
        case arrivalDateTime = "arrival_datetime"
        case departureDateTime = "departure_datetime"
        case numberOfAdults = "number_of_adults"
        case numberOfChildren = "number_of_children"
        case answers
        case tripAnswers = "trip_answers"
        case owner
        case startCoordinate = "start_coordinate"
        case accommodationAddress = "accommodation_address"
        case companionIds = "companion_ids"
        case pace
        case doNotGenerate = "do_not_generate"
    }
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityId = try values.decode(Int.self, forKey: .cityId)
        arrivalDateTime = try values.decodeIfPresent(String.self, forKey: .arrivalDateTime)
        departureDateTime = try values.decodeIfPresent(String.self, forKey: .departureDateTime)
        
        numberOfAdults = try values.decode(Int.self, forKey: .numberOfAdults)
        numberOfChildren = try values.decodeIfPresent(Int.self, forKey: .numberOfChildren)
    
        if let startCoordinate = try values.decodeIfPresent(TRPCoordinateModel.self, forKey: .startCoordinate) {
            self.startCoordinate = startCoordinate
        }
        
        self.accommodationAddress = try values.decodeIfPresent(String.self, forKey: .accommodationAddress)
        self.answers = try values.decode([Int].self, forKey: .answers)
        self.tripAnswers = try values.decode([Int].self, forKey: .tripAnswers)
        self.owner = try values.decodeIfPresent(String.self, forKey: .owner)
        self.companionIds = try values.decode([Int].self, forKey: .companionIds)
        self.pace = try values.decodeIfPresent(String.self, forKey: .pace)
        self.doNotGenerate = try values.decode(Int.self, forKey: .doNotGenerate)
    }

}
