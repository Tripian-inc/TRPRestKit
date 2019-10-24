//
//  TRPRecommendation.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 8.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPRecommendation: TRPRestServices{
    
    var setting: TRPRecommendationSettings;
    var limit: Int = 15
    
    internal init(settings:TRPRecommendationSettings) {
        self.setting = settings
    }
    
    public override func servicesResult(data: Data?, error: NSError?) {
        
        if let error = error {
            self.Completion?(nil,error, nil);
            return
        }
        
        guard let data = data else {
            self.Completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        
        let jsonDecode = JSONDecoder();
        do {
            let result = try jsonDecode.decode(TRPRecommendationJsonModel.self, from: data)
            let pag = paginationController(parentJson: result)
            self.Completion?(result, nil, pag);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.recommendations.link;
    }
    
    public override func parameters() -> Dictionary<String, Any>? {
        var params : Dictionary<String, Any> = [:];

        if setting.cityId == nil && setting.hash == nil {
            return [:]
        }
        
        if let cityId = setting.cityId {
            params["city_id"] = cityId
        }
        
        if let hash = setting.hash {
            params["hash"] = hash
        }
        
        if let typeIds = setting.poiCategoryIds {
            //TODO: - FOUNDATİON DAN AL
            let typeIdList = typeIds.map{"\($0)"}.joined(separator: ",")
            params["poi_categories"] = typeIdList
        }
        if let adults = setting.adultsCount {
            params["adults"] = adults
        }
        if let adultAgeRange = setting.adultAgeRange {
            params["adult_age_range"] = adultAgeRange
        }
        if let childrenCount = setting.childrenCount{
            params["children"] = childrenCount
        }
        if let childrenAgeRange = setting.childrenAgeRange {
            params["children_age_range"] = childrenAgeRange
        }
        if let coord = setting.currentCoordinate {
            params["coordinate"] = coord // int
        }
        
        if let answer = setting.answer {
            // TODO FOUNDATİON KİT DEN GÜNCELLE
            let answersMap = answer.map{"\($0)"}.joined(separator: ",")
            params["answers"] = answersMap;
        }
        
        return params;
    }
    
}
