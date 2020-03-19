//
//  TRPRecommendation.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 8.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit

internal class TRPRecommendation: TRPRestServices<TRPGenericParser<[TRPRecommendationInfoJsonModel]>> {
    
    var setting: TRPRecommendationSettings
    var limit: Int = 15
    
    internal init(settings: TRPRecommendationSettings) {
        self.setting = settings
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.recommendations.link
    }
    
    public override func parameters() -> [String: Any]? {
        var params: [String: Any] = [:]

        if setting.cityId == nil && setting.hash == nil {
            return [:]
        }
        
        if let cityId = setting.cityId {
            params["city_id"] = cityId
        }
        
        if let hash = setting.hash {
            params["trip_hash"] = hash
        }
        
        if let typeIds = setting.poiCategoryIds {
            params["poi_categories"] = typeIds//.toString()
        }
        if let adults = setting.adultsCount {
            params["adults"] = adults
        }
        if let adultAgeRange = setting.adultAgeRange {
            params["adult_age_average"] = adultAgeRange
        }
        if let childrenCount = setting.childrenCount {
            params["children"] = childrenCount
        }
        if let childrenAgeRange = setting.childrenAgeRange {
            params["children_age_average"] = childrenAgeRange
        }
        if let coord = setting.currentCoordinate {
            params["coordinate"] = coord // int
        }
        
        if let answer = setting.answer {
            params["answers"] = [95]// answer//.toString()
        }
        
        return params
    }
    
}
