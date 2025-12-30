//
//  TRPTimelineSegmentSettings.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 08.08.2025.
//  Copyright © 2025 Cem Çaygöz. All rights reserved.
//

import Foundation
import TRPFoundationKit
/// This model provides you all setting to create/edit timeline segments.
public class TRPTimelineSegmentSettings: Codable {

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
    /// Array of specific points of interest to include.
    public var includePoiIds: [Int]?
    /// A Int value. If you set 1, trip is not going to generate.
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

    // New fields from API response
    /// Enable smart recommendation
    public var smartRecommendation: Bool?
    /// Free text for activity description
    public var activityFreeText: String?
    /// Array of activity IDs to include
    public var activityIds: [String]?
    /// Array of activity IDs to exclude
    public var excludedActivityIds: [String]?
    /// Generated status indicator
    public var generatedStatus: Int?
    /// Array of day IDs associated with this segment
    public var dayIds: [Int]?
    /// Type of segment (e.g., "booked_activity", "generated", etc.)
    public var segmentType: String?
    /// Additional data for booked activities or custom segments
    public var additionalData: TRPTimelineSegmentAdditionalData?
    /// Accommodation information (from response)
    public var accommodation: Accommondation?
    /// Destination accommodation information (from response)
    public var destinationAccommodation: Accommondation?

    /// Public initializer to allow instantiation from other modules
    public init() {}

    private enum CodingKeys: String, CodingKey {
        case segmentIndex, cityId, title, description, startDate, endDate
        case adults, children, pets, coordinate, destinationCoordinate
        case answerIds, doNotRecommend, excludePoiIds, includePoiIds
        case doNotGenerate, considerWeather, distinctPlan, available, hash
        case smartRecommendation, activityFreeText, activityIds, excludedActivityIds
        case generatedStatus, dayIds, segmentType, additionalData
        case accommodation, destinationAccommodation
    }
    
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

        // New fields
        if let smartRecommendation = smartRecommendation {
            params["smartRecommendation"] = smartRecommendation
        }
        if let activityFreeText = activityFreeText {
            params["activityFreeText"] = activityFreeText
        }
        if let activityIds = activityIds, !activityIds.isEmpty {
            params["activityIds"] = activityIds
        }
        if let excludedActivityIds = excludedActivityIds, !excludedActivityIds.isEmpty {
            params["excludedActivityIds"] = excludedActivityIds
        }
        if let includePoiIds = includePoiIds, !includePoiIds.isEmpty {
            params["includePoiIds"] = includePoiIds
        }
        if let generatedStatus = generatedStatus {
            params["generatedStatus"] = generatedStatus
        }
        if let dayIds = dayIds, !dayIds.isEmpty {
            params["dayIds"] = dayIds
        }
        if let segmentType = segmentType {
            params["segmentType"] = segmentType
        }
        if let additionalData = additionalData, let json = additionalData.json() {
            params["additionalData"] = json
        }

        params["doNotGenerate"] = doNotGenerate
        params["available"] = available

        return params
    }
}

/// Additional data for timeline segments (booked activities, custom segments, etc.)
public struct TRPTimelineSegmentAdditionalData: Codable {
    /// Activity ID
    public var activityId: String?
    /// Booking ID
    public var bookingId: String?
    /// Title of the activity
    public var title: String?
    /// Image URL
    public var imageUrl: String?
    /// Description
    public var description: String?
    /// Start date and time
    public var startDatetime: String?
    /// End date and time
    public var endDatetime: String?
    /// Location coordinate
    public var coordinate: TRPLocation?
    /// Cancellation policy
    public var cancellation: String?
    /// Price of the booked activity
    public var price: Double?
    /// Duration in minutes
    public var duration: Double?

    public init() {}

    public func json() -> [String: Any]? {
        var params: [String: Any] = [:]

        if let activityId = activityId {
            params["activityId"] = activityId
        }
        if let bookingId = bookingId {
            params["bookingId"] = bookingId
        }
        if let title = title {
            params["title"] = title
        }
        if let imageUrl = imageUrl {
            params["imageUrl"] = imageUrl
        }
        if let description = description {
            params["description"] = description
        }
        if let startDatetime = startDatetime {
            params["startDatetime"] = startDatetime
        }
        if let endDatetime = endDatetime {
            params["endDatetime"] = endDatetime
        }
        if let coordinate = coordinate {
            params["coordinate"] = coordinate.json()
        }
        if let cancellation = cancellation {
            params["cancellation"] = cancellation
        }
        if let price = price {
            params["price"] = price
        }
        if let duration = duration {
            params["duration"] = duration
        }

        return params.isEmpty ? nil : params
    }
}
