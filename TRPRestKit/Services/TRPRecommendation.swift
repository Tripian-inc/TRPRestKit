//
//  TRPRecommendation.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 8.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

internal class TRPRecommendation: TRPRestServices{
    
    var setting:TRPRecommendationSettings;
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
            let typeIdList = typeIds.map{"\($0)"}.joined(separator: ",")
            params["type_id"] = typeIdList
        }
        if let rating = setting.rating {
            params["rating"] = rating
        }
        if let distance = setting.distance {
            params["distance"] = distance
        }
        if let popularity = setting.popularity{
            params["popularity"] = popularity
        }
        if let currentCoor = setting.currentCoordinate {
            params["current_coord"] = "\(currentCoor)" // int
        }
        if let answer = setting.answer {
            let answersMap = answer.map{"\($0)"}.joined(separator: ",")
            params["answer"] = answersMap;
        }
        if let limit = setting.limit {
            params["limit"] = limit // int
        }
        
        return params;
    }
    
}
