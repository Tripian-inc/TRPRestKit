//
//  TRPGetProgramJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
/// Indicates parameters used when creating a trip.
public struct TRPGetProgramParamsInfoModel: Decodable {
    
    /// An Int value. Id of city.
    public var cityId: String?;
    /// A String value. Arrival date of trip.
    public var arrivalDate: String?;
    /// A String value. Departure date of trip.
    public var departureDate: String?;
    /// A String value. Arrival time of trip.
    public var arrivalTime:String?;
    /// A String value. Departure time of trip.
    public var departureTime: String?;
    /// An Int value. Adult count.
    public var adults: Int?;
    /// An Int value. Adults age range such as 32
    public var adultAgeRange: Int?
    /// An Int value. Count of Children
    public var children: Int?
    /// An Int value. Children age range such as 12
    public var childrenAgeRange: Int?
    /// A String value. Center coordinate of hotel (41.123,29.4532)
    public var coordinate: String?
    /// A String value. Address of hotel.
    public var hotelAddress: String?
    /// A String value. Answer of questions.You must convert to Array.
    public var answers = [Int]()
    /// A String value. Companion of users for the selected trip.You must convert to Array.
    public var companions = [Int]()
    
    
    private enum CodingKeys: String, CodingKey {
        case cityId = "city_id";
        case arrivalDate = "arrival_date";
        case departureDate = "departure_date";
        case arrivalTime = "arrival_time";
        case departureTime = "departure_time";
        case adults
        case adultAgeRange = "adult_age_average"
        case children
        case childAgeRange = "children_age_average"
        case coordinate
        case answers
        case hotelAddress = "hotel_address"
        case companions
    }
    
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        cityId = try values.decodeIfPresent(String.self, forKey: .cityId);
        arrivalDate = try values.decodeIfPresent(String.self, forKey: .arrivalDate);
        departureDate = try values.decodeIfPresent(String.self, forKey: .departureDate);
        arrivalTime = try values.decodeIfPresent(String.self, forKey: .arrivalTime);
        departureTime = try values.decodeIfPresent(String.self, forKey: .departureTime);
        
        if let adults = try values.decodeIfPresent(String.self, forKey: .adults), let adultsCount = Int(adults) {
            self.adults = adultsCount
        }
        
        if let children = try values.decodeIfPresent(String.self, forKey: .children), let childrenCount = Int(children) {
            self.children = childrenCount
        }
        
        if let ageRange = try values.decodeIfPresent(String.self, forKey: .adultAgeRange), let range = Int(ageRange) {
            self.adultAgeRange = range
        }
        
        if let ageRange = try values.decodeIfPresent(String.self, forKey: .childAgeRange), let range = Int(ageRange) {
            self.childrenAgeRange = range
        }
        
        self.coordinate = try values.decodeIfPresent(String.self, forKey: .coordinate)
        
        self.hotelAddress = try values.decodeIfPresent(String.self, forKey: .hotelAddress)
        
        if let answersStr = try values.decodeIfPresent(String.self, forKey: .answers) {
            let ar = answersStr.components(separatedBy: ",")
            answers = ar.map { (s) -> Int in
                return Int(s) ?? -1
            }
        }
        
        if let companionsStr = try values.decodeIfPresent(String.self, forKey: .companions) {
            let ar = companionsStr.components(separatedBy: ",")
            companions = ar.map { (s) -> Int in
                return Int(s) ?? -1
            }
        }
    }

}


