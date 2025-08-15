//
//  TRPTimelineSettings.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation
import TRPFoundationKit
/// This model provides you all setting to create trip.
public class TRPTimelineSettings {

    /// An Int value. Id of city.
    public var cityId: Int?
    /// An Int value. Adult count.
    public var adults: Int = 1
    /// An Int value. Count of Children
    public var children: Int = 0
    /// An Int value. Count of Pets
    public var pets: Int = 0
    /// Array of preference IDs to customize your experience.
    public var answers: [Int] = []
    /// Array of categories you wish to exclude.
    public var doNotRecommend: [Int]?
    /// Array of specific points of interest to exclude.
    public var excludePoiIds: [Int]?
    /// Takes into account the hourly weather forecasts for the current day and the next 2 days when set to true
    public var considerWeather: Bool = false
    /// Array of segment profiles.
    public var segments: [TRPTimelineSegmentSettings]?
    
    
    public init(cityId: Int) {
        self.cityId = cityId
    }
    
    public func getParameters() -> [String: Any] {
        var params: [String: Any] = [:]
        
        if let cityId = cityId {
            params["cityId"] = cityId
        }
        
        params["adults"] = adults
        params["children"] = children
        params["pets"] = pets
        
        if !answers.isEmpty {
            params["answers"] = answers
        }
        if let doNotRecommend = doNotRecommend {
            params["doNotRecommend"] = doNotRecommend
        }
        if let excludePoiIds = excludePoiIds {
            params["excludePoiIds"] = excludePoiIds
        }
        
        params["considerWeather"] = considerWeather
        
        if let segments = segments {
            params["segments"] = segments.map { $0.getParameters() }
        }
        
        return params
    }
}
