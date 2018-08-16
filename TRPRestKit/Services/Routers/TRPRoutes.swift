//
//  TRPRoutes.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 10.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPRoutes: TRPRestServices{
    
    var setting:TRPRoutesSettings;
    
    internal init(settings:TRPRoutesSettings) {
        self.setting = settings;
    }
    
    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.Completion?(nil,error, nil);
            return
        }
        
        guard let data = data else {
            self.Completion?(nil, TRPErrors.wrongData as NSError,  nil)
            return
        }
        
        let jsonDecode = JSONDecoder();
        do {
            let result = try jsonDecode.decode(TRPRoutesJsonModel.self, from: data)
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        let path = TRPConfig.ApiCall.Routes.link;
        return path;
    }
    
    public override func parameters() -> Dictionary<String, Any>? {
        
        var params : Dictionary<String, Any> = [:];
        params["city_id"] = setting.cityId;
        params["arrival_date"] = setting.arrivalTime.date
        params["arrival_time"] = setting.arrivalTime.time;
        params["departure_date"] = setting.departureTime.date
        params["departure_time"] = setting.departureTime.time
        params["adults"] = String(setting.adultsCount);
        
        if let adultAgeRange = setting.adultAgeRange {
            params["adult_age_range"] = String(adultAgeRange);
        }
        
        if let children = setting.childrenCount {
            params["children"] = String(children);
        }
        
        if let ageRange = setting.adultAgeRange {
            params["children_age_range"] = ageRange;
        }
        
        if let coordinate = setting.coordinate {
            params["coord"] = coordinate;
        }
        
        if let coordinate = setting.coordinate {
            params["coord"] = coordinate;
        }
        
        if let answer = setting.answer {
            params["answer"] = answer.map{"\($0)"}.joined(separator: ",")
        }
        
        return params;
    }
    
}
