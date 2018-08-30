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
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.Recommendations.link;
    }
    
    public override func parameters() -> Dictionary<String, Any>? {
        var params : Dictionary<String, Any> = [:];
        params["city_id"] = setting.cityId
        
        if let typeIds = setting.typeId {
            //TODO: - FOUNDATİON DAN AL
            let typeIdList = typeIds.map{"\($0)"}.joined(separator: ",")
            params["type_id"] = typeIdList
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
            params["coord"] = coord // int
        }
        
        if let hash = setting.hash {
            params["hash"] = hash
        }
        
        if let type = setting.type {
            params["type"] = type
        }
        
        if let answer = setting.answer {
            // TODO FOUNDATİON KİT DEN GÜNCELLE
            let answersMap = answer.map{"\($0)"}.joined(separator: ",")
            params["answer"] = answersMap;
        }
        
        return params;
    }
    
}
