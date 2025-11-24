//
//  TRPTimelineSegmentSettings.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation
import TRPFoundationKit
/// This model provides you all setting to create/ed,it .
public class TRPTimelineSegmentSettings {

    /// Segment Index. This parameter must be filled when using edit segment use case.
    public var segmentIndex: Int?
    /// An Int value. Id of city.
    public var cityId: Int?
    /// Title of segment
    public var title: String?
    /// Description of segment
    public var description: String?
    /// Start date of segment
    public var startDate: String?
    /// End date of segment
    public var endDate: String?
    /// An Int value. Adult count.
    public var adults: Int = 1
    /// An Int value. Count of Children
    public var children: Int?
    /// An Int value. Count of Pets
    public var pets: Int?
    /// Coordinate of start point
    public var coordinate: TRPLocation?
    /// Coordinate of end point. If the ending point is the same as the starting point, this field can be omitted
    public var destinationCoordinate: TRPLocation?
    /// Array of preference IDs to customize your experience.
    public var answerIds: [Int] = []
    /// Array of categories you wish to exclude.
    public var doNotRecommend: [String]?
    /// Array of specific points of interest to exclude.
    public var excludePoiIds: [Int]?
//    /// A Int value. If you set 1, trip is not going to generate.
    public var doNotGenerate: Int = 0
    /// Takes into account the hourly weather forecasts for the current day and the next 2 days when set to true
    public var considerWeather: Bool?
    /// When set to true, ensures that the recommendations generated for this segment will not include places that were already suggested in other segments of the trip
    public var distinctPlan: Bool?
    public var available: Bool = true
    public var hash: String?
    /// A String value. Address of hotel.
    public var accommodationAdress: Accommondation?
    /// A String value. Address of destination hotel.
    public var destinationAccommodationAdress: Accommondation?
    
    /// Public initializer to allow instantiation from other modules
    public init() {}
    
    public func getParameters() -> [String: Any] {
        var params: [String: Any] = [:]
            
        if let segmentIndex = segmentIndex {
            params["segmentIndex"] = segmentIndex
        }
        if let cityId = cityId {
            params["cityId"] = cityId
        }
        if let title = title {
            params["title"] = title
        }
        if let description = description {
            params["description"] = description
        }
        if let startDate = startDate {
            params["startDate"] = startDate
        }
        if let endDate = endDate {
            params["endDate"] = endDate
        }
        
        params["adults"] = adults
        
        if let children = children {
            params["children"] = children
        }
        if let pets = pets {
            params["pets"] = pets
        }
        
        if let coordinate = coordinate {
            params["coordinate"] = coordinate.json()
        }
        
        if let destinationCoordinate = destinationCoordinate {
            params["destinationCoordinate"] = destinationCoordinate.json()
        }
        
        if !answerIds.isEmpty {
            params["answerIds"] = answerIds
        }
        if let doNotRecommend = doNotRecommend {
            params["doNotRecommend"] = doNotRecommend
        }
        if let excludePoiIds = excludePoiIds {
            params["excludePoiIds"] = excludePoiIds
        }
        if let considerWeather = considerWeather {
            params["considerWeather"] = considerWeather
        }
        if let distinctPlan = distinctPlan {
            params["distinctPlan"] = distinctPlan
        }
        if let accommodationAdress = accommodationAdress, let accomJson = accommodationAdress.json() {
            params["accommodation"] = accomJson
        }
        if let destinationAccommodationAdress = destinationAccommodationAdress, let accomJson = destinationAccommodationAdress.json() {
            params["destinationAccommodation"] = accomJson
        }
        
        params["doNotGenerate"] = doNotGenerate
        params["available"] = available
        
        return params
    }
}
