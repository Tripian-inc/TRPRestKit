//
//  TRPTimelineSegmentProfile.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 14.08.2025.
//  Copyright © 2025 Evren Yaşar. All rights reserved.
//


import TRPFoundationKit


public class TRPTimelineSegmentModel: Codable {
    public var available: Bool = true
    public var title: String?
    public var description: String?
    public var startDate: String?
    public var endDate: String?
    public var coordinate: [TRPLocation]?
    public var destinationCoordinate: [TRPLocation]?
    public var adults: Int = 1
    public var children: Int = 0
    public var pets: Int = 0
    public var cityId: Int?
    public var generatedStatus: Int?
    public var answerIds: [Int]?
    public var doNotRecommend: [Int]?
    public var excludePoiIds: [Int]?
    public var includePoiIds: [Int]?
    public var dayIds: [Int]?
    public var considerWeather: Bool = false
    public var distinctPlan: Bool = false
    

}
