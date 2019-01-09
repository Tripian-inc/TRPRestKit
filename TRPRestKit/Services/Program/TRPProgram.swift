//
//  TRPProgram.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPProgram: TRPRestServices{
    
    var setting: TRPTripSettings?
    
    internal override init() {}
    
    internal init(setting: TRPTripSettings) {
        self.setting = setting
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
            let result = try jsonDecode.decode(TRPTripJsonModel.self, from: data)
            let pag = paginationController(parentJson: result)
            self.Completion?(result, nil, pag);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.Trip.link
    }
    
    override func requestMode() -> TRPRequestMode {
        return TRPRequestMode.post
    }
 
    override func userOAuth() -> Bool {
        return true
    }
    
    public override func parameters() -> Dictionary<String, Any>? {
        var params : Dictionary<String, Any> = [:];
        
        guard let setting = setting else {
            return params
        }
        
        params["city_id"] = setting.cityId;
        params["arrival_date"] = setting.arrivalTime.date
        params["arrival_time"] = setting.arrivalTime.time;
        params["departure_date"] = setting.departureTime.date
        params["departure_time"] = setting.departureTime.time
        params["adults"] = String(setting.adultsCount);
        
        if let adultAgeRange = setting.adultAgeRange {
            params["adult_age_range"] = adultAgeRange;
        }
        
        if let children = setting.childrenCount {
            params["children"] = String(children);
        }
        
        if let ageRange = setting.childrenAgeRange {
            params["children_age_range"] = ageRange;
        }
        
        if let coordinate = setting.coordinate {
            params["coord"] = coordinate;
        }
        
        if let answer = setting.answer {
            params["answers"] = answer.map{"\($0)"}.joined(separator: ",")
        }
        
        if let hotel = setting.hotelAddress {
            params["hotel_address"] = hotel
        }
        
        if let doNotGenerate = setting.doNotGenerate {
            params["do_not_generate"] = doNotGenerate
        }
        return params;
    }
    
}
