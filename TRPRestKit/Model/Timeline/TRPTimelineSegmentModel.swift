//
//  TRPTimelineSegmentProfile.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 14.08.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//


import TRPFoundationKit


public class TRPTimelineSegmentModel: Decodable {
    public var available: Bool = true
    public var title: String?
    public var description: String?
    public var startDate: String?
    public var endDate: String?
    public var coordinate: TRPLocation?
    public var destinationCoordinate: TRPLocation?
    public var adults: Int = 1
    public var children: Int = 0
    public var pets: Int = 0
    public var cityId: Int?
    public var generatedStatus: Int?
    public var answerIds: [Int]?
    public var doNotRecommend: [String]?
    public var excludePoiIds: [Int]?
    public var includePoiIds: [Int]?
    public var dayIds: [Int]?
    public var considerWeather: Bool = false
    public var distinctPlan: Bool = false
    public var accommodation: TRPAccommodationInfoModel?
    public var destinationAccommodation: TRPAccommodationInfoModel?

    // New fields from API response
    public var smartRecommendation: Bool?
    public var activityFreeText: String?
    public var activityIds: [String]?
    public var excludedActivityIds: [String]?
    public var segmentType: String?
    public var additionalData: TRPTimelineSegmentAdditionalData?

    enum CodingKeys: String, CodingKey {
        case available, title, description, startDate, endDate, coordinate, destinationCoordinate,
             adults, children, pets, cityId, generatedStatus, answerIds, doNotRecommend,
             excludePoiIds, includePoiIds, dayIds, considerWeather, distinctPlan, accommodation, destinationAccommodation,
             smartRecommendation, activityFreeText, activityIds, excludedActivityIds, segmentType, additionalData
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        available = try container.decodeIfPresent(Bool.self, forKey: .available) ?? true
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        startDate = try container.decodeIfPresent(String.self, forKey: .startDate)
        endDate = try container.decodeIfPresent(String.self, forKey: .endDate)
        coordinate = try container.decodeIfPresent(TRPLocation.self, forKey: .coordinate)
        destinationCoordinate = try container.decodeIfPresent(TRPLocation.self, forKey: .destinationCoordinate)
        adults = try container.decodeIfPresent(Int.self, forKey: .adults) ?? 1
        children = try container.decodeIfPresent(Int.self, forKey: .children) ?? 0
        pets = try container.decodeIfPresent(Int.self, forKey: .pets) ?? 0
        cityId = try container.decodeIfPresent(Int.self, forKey: .cityId)
        generatedStatus = try container.decodeIfPresent(Int.self, forKey: .generatedStatus)
        answerIds = try container.decodeIfPresent([Int].self, forKey: .answerIds)
        doNotRecommend = try container.decodeIfPresent([String].self, forKey: .doNotRecommend)
        excludePoiIds = try container.decodeIfPresent([Int].self, forKey: .excludePoiIds)
        includePoiIds = try container.decodeIfPresent([Int].self, forKey: .includePoiIds)
        dayIds = try container.decodeIfPresent([Int].self, forKey: .dayIds)
        considerWeather = try container.decodeIfPresent(Bool.self, forKey: .considerWeather) ?? false
        distinctPlan = try container.decodeIfPresent(Bool.self, forKey: .distinctPlan) ?? false

        if let accommondation = try? container.decodeIfPresent(TRPAccommodationInfoModel.self, forKey: .accommodation) {
            self.accommodation = accommondation
        }

        if let destinationAccommodation = try? container.decodeIfPresent(TRPAccommodationInfoModel.self, forKey: .destinationAccommodation) {
            self.destinationAccommodation = destinationAccommodation
        }

        // New fields
        smartRecommendation = try container.decodeIfPresent(Bool.self, forKey: .smartRecommendation)
        activityFreeText = try container.decodeIfPresent(String.self, forKey: .activityFreeText)
        activityIds = try container.decodeIfPresent([String].self, forKey: .activityIds)
        excludedActivityIds = try container.decodeIfPresent([String].self, forKey: .excludedActivityIds)
        segmentType = try container.decodeIfPresent(String.self, forKey: .segmentType)
        additionalData = try container.decodeIfPresent(TRPTimelineSegmentAdditionalData.self, forKey: .additionalData)
    }
    
    public init() {} // empty init if needed
}
