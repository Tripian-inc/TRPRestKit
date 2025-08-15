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
    public var children: Int = 0
    /// An Int value. Count of Pets
    public var pets: Int = 0
    /// Coordinate of start point
    private(set) var coordinate: [TRPLocation]?
    /// Coordinate of end point. If the ending point is the same as the starting point, this field can be omitted
    private(set) var destinationCoordinate: [TRPLocation]?
    /// Array of preference IDs to customize your experience.
    public var answerIds: [Int] = []
    /// Array of categories you wish to exclude.
    public var doNotRecommend: [Int]?
    /// Array of specific points of interest to exclude.
    public var excludePoiIds: [Int]?
    /// A Bool value. If you set true, trip is not going to generate.
    public var doNotGenerate: Bool = false
    /// Takes into account the hourly weather forecasts for the current day and the next 2 days when set to true
    public var considerWeather: Bool = false
    /// When set to true, ensures that the recommendations generated for this segment will not include places that were already suggested in other segments of the trip
    public var distinctPlan: Bool = false
    
    public var hash: String?
    
    
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
        params["children"] = children
        params["pets"] = pets
        
        if let coordinate = coordinate {
            params["coordinate"] = coordinate.map { $0.json() }
        }
        
        if let destinationCoordinate = destinationCoordinate {
            params["destinationCoordinate"] = destinationCoordinate.map { $0.json() }
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
        
        params["doNotGenerate"] = doNotGenerate
        params["considerWeather"] = considerWeather
        params["distinctPlan"] = distinctPlan
        
        if let hash = hash {
            params["hash"] = hash
        }
        
        return params
    }
}
