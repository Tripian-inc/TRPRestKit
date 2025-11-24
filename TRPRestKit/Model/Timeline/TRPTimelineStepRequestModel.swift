//
//  TRPTimelineStepRequestModel.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 20.08.2025.
//  Copyright © 2025 Evren Yaşar. All rights reserved.
//

import TRPFoundationKit

/// A model representing the request payload for creating a new timeline step via the Tripian API.
/// Timeline steps are individual components of a travel itinerary that can include visits to points of interest,
/// custom locations, or other travel activities with specific timing and ordering.
public struct TRPTimelineStepCreateModel: Codable {
    /// The unique identifier of the daily plan to which this timeline step belongs.
    /// This is a required field that associates the step with a specific day in the travel itinerary.
    var planId: Int
    
    /// Optional identifier of an existing Point of Interest (POI) from the Tripian database.
    /// Use this when the timeline step refers to a known location in the system.
    var poiId: String?
    
    /// Optional type classification for the timeline step (e.g., "poi", "event").
    /// This helps categorize the nature of the step within the itinerary.
    var stepType: String?
    
    /// Optional custom POI model for creating timeline steps with user-defined locations.
    /// Use this when the desired location is not available in the Tripian POI database.
    var customPoi: TRPTimelineStepCustomPoiModel?
    
    /// Optional start time for the timeline step in HH:mm format (e.g., "12:00", "14:30").
    /// Defines when the activity or visit is scheduled to begin.
    var startTime: String?
    
    /// Optional end time for the timeline step in HH:mm format (e.g., "13:00", "15:45").
    /// Defines when the activity or visit is scheduled to conclude.
    var endTime: String?
    
    /// Optional ordering index for the timeline step within the daily plan.
    /// Lower numbers appear earlier in the itinerary sequence.
    var order: Int?
    
    public init(planId: Int, poiId: String? = nil, stepType: String? = nil, customPoi: TRPTimelineStepCustomPoiModel? = nil, startTime: String? = nil, endTime: String? = nil, order: Int? = nil) {
        self.planId = planId
        self.poiId = poiId
        self.stepType = stepType
        self.customPoi = customPoi
        self.startTime = startTime
        self.endTime = endTime
        self.order = order
    }
}

extension TRPTimelineStepCreateModel {
    func getBodyParameters() -> [String: Any] {
        var parameters: [String: Any] = [
            "planId": planId
        ]
        
        if let poiId = poiId {
            parameters["poiId"] = poiId
        }
        
        if let stepType = stepType {
            parameters["stepType"] = stepType
        }
        
        if let startTime = startTime {
            parameters["startTime"] = startTime
        }
        
        if let endTime = endTime {
            parameters["endTime"] = endTime
        }
        
        if let order = order {
            parameters["order"] = order
        }
        
        if let customPoi {
            parameters["customPoi"] = customPoi.getBodyParameters()
        }
        return parameters
    }
}

// MARK: - Edit Timeline Step Model

/// A model representing the request payload for editing an existing timeline step via the Tripian API.
/// This model allows updating specific properties of an existing timeline step without requiring
/// all fields to be provided, enabling partial updates to the itinerary.
public struct TRPTimelineStepEditModel: Codable {
    /// The unique identifier of the timeline step to be edited.
    /// This is a required field that specifies which step should be updated.
    var stepId: Int
    
    /// Optional identifier of an existing Point of Interest (POI) from the Tripian database.
    /// Update this when changing the timeline step to refer to a different known location.
    var poiId: String?
    
    /// Optional type classification for the timeline step (e.g., "poi", "event").
    /// Update this to change the categorization of the step within the itinerary.
    var stepType: String?
    
    /// Optional custom POI model for updating timeline steps with user-defined locations.
    /// Use this when changing the step to use a custom location not in the Tripian database.
    var customPoi: TRPTimelineStepCustomPoiModel?
    
    /// Optional start time for the timeline step in HH:mm format (e.g., "12:00", "14:30").
    /// Update this to change when the activity or visit is scheduled to begin.
    var startTime: String?
    
    /// Optional end time for the timeline step in HH:mm format (e.g., "13:00", "15:45").
    /// Update this to change when the activity or visit is scheduled to conclude.
    var endTime: String?
    
    /// Optional ordering index for the timeline step within the daily plan.
    /// Update this to change the position of the step in the itinerary sequence.
    var order: Int?
    
    public init(stepId: Int, poiId: String? = nil, stepType: String? = nil, customPoi: TRPTimelineStepCustomPoiModel? = nil, startTime: String? = nil, endTime: String? = nil, order: Int? = nil) {
        self.stepId = stepId
        self.poiId = poiId
        self.stepType = stepType
        self.customPoi = customPoi
        self.startTime = startTime
        self.endTime = endTime
        self.order = order
    }
}

extension TRPTimelineStepEditModel {
    func getBodyParameters() -> [String: Any] {
        var parameters: [String: Any] = [:]
        
        if let poiId = poiId {
            parameters["poiId"] = poiId
        }
        
        if let stepType = stepType {
            parameters["stepType"] = stepType
        }
        
        if let customPoi = customPoi {
            parameters["customPoi"] = customPoi.getBodyParameters()
        }
        
        if let startTime = startTime {
            parameters["startTime"] = startTime
        }
        
        if let endTime = endTime {
            parameters["endTime"] = endTime
        }
        
        if let order = order {
            parameters["order"] = order
        }
        
        return parameters
    }
}
