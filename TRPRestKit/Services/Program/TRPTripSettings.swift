//
//  TRPProgramSettings.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// This model provides you all setting to create trip.
public class TRPTripSettings {
    
    /// An Int value. Id of city.
    public var cityId: Int?
    /// A TRPTime object. Arrival date of trip.
    public var arrivalTime: TRPTime
    /// A TRPTime object. Departure date of trip.
    public var departureTime: TRPTime
    /// An Int value. Adult count.
    public var adultsCount: Int = 1
    /// A String value. Adults age range such as 32
    public var adultAgeRange: String?
    /// An Int value. Count of Children
    public var childrenCount: Int?
    /// A String value. Children age range such as 12
    public var childrenAgeRange: String?
    /// A String value. Center coordinate of hotel (41.123,29.4532)
    private(set) var coordinate: String?
    /// A String value. Address of hotel.
    private(set) var hotelAddress: String?
    /// An Int array. Answer of trip questions.
    public var tripAnswer: [Int] = []
    /// An Int array. Answer of profile questions.
    public var profileAnswer: [Int] = []
    /// An Int array. Selected companion ids.
    public var selectedCompanionIds: [Int]?
    /// A Bool value. If you set true, trip is not going to generate.
    public var doNotGenerate: Bool = false
    
    public var hash: String?
    
    /// Initializes a new Settings with cityId, arrivalTime and departureTime
    ///
    /// - Parameters:
    ///   - cityId: Id of city
    ///   - arrivalTime: Arrival time
    ///   - departureTime: Departure time
    public init(cityId: Int, arrivalTime: TRPTime, departureTime: TRPTime) {
        self.cityId = cityId
        self.arrivalTime = arrivalTime
        self.departureTime = departureTime
    }
    
    public init(hash: String, arrivalTime: TRPTime, departureTime: TRPTime) {
        self.hash = hash
        self.arrivalTime = arrivalTime
        self.departureTime = departureTime
    }
    
    /// Address of Hotel. The hotel is going to be First step in trip.
    ///
    /// - Parameters:
    ///   - lat: Latitude
    ///   - lon: longitude
    ///   - hotelAddress: Hodel adress.
    public func setCoordinateWithAddress(lat: Double, lon: Double, hotelAddress: String) {
        coordinate = String(lat) + "," + String(lon)
        self.hotelAddress  = hotelAddress
    }
    
    public func getAllAnswers() -> [Int] {
        var tempAns = [Int]()
        tempAns.append(contentsOf: tripAnswer)
        tempAns.append(contentsOf: profileAnswer)
        return tempAns
    }
}
