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
        var link = TRPConfig.ApiCall.Trip.link
        if let hash = setting?.hash {
            link += "/\(hash)"
        }
        return link
    }
    
    override func requestMode() -> TRPRequestMode {
        if setting?.hash != nil {
            return .put
        }
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
        
        //Edit
        if let hash = setting.hash {
            params["hash"] = hash;
        }else {//Create
            params["city_id"] = setting.cityId;
        }
        
        params["arrival_date"] = setting.arrivalTime.date
        params["arrival_time"] = setting.arrivalTime.time;
        params["departure_date"] = setting.departureTime.date
        params["departure_time"] = setting.departureTime.time
        params["adults"] = String(setting.adultsCount);
        
        if let adultAgeRange = setting.adultAgeRange {
            params["adult_age_average"] = adultAgeRange;
        }
        
        if let children = setting.childrenCount {
            params["children"] = String(children);
        }
        
        if let ageRange = setting.childrenAgeRange {
            params["children_age_average"] = ageRange;
        }
        
        if let answer = setting.answer {
            params["answers"] = answer.map{"\($0)"}.joined(separator: ",")
        }
        params["coordinate"] = setting.coordinate ?? ""
        /*if let coordinate = setting.coordinate {
            
        }*/
        params["hotel_address"] = setting.hotelAddress ?? ""
/*        if let hodelAddreess = setting.hotelAddress {
            
        }**/
        
        
        
        let gen = setting.doNotGenerate == true ? 1 : 0
        
        params["do_not_generate"] = gen
        
        if let companions = setting.selectedCompanionIds{
            params["companions"] = companions.map{"\($0)"}.joined(separator: ",")
        }
        
        return params;
    }
    
}
