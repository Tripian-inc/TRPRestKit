//
//  TRPCities.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 2.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit
internal class TRPCities: TRPRestServices{
    
    private enum RequestType {
        case allCities
        case cityWithId
        case cityWithLocation
    }
    
    private var cityId:Int?;
    private var requestType: RequestType = RequestType.allCities
    private var location: TRPLocation?
    
    internal override init() {}
    
    internal init(cityId:Int) {
        self.requestType = .cityWithId
        self.cityId = cityId;
    }
    
    internal init(location: TRPLocation) {
        self.requestType = .cityWithLocation
        self.location = location
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
            let result = try jsonDecode.decode(TRPCityJsonModel.self, from: data)
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        var path = ""
        
        if requestType == .allCities || requestType == .cityWithId {
            path = TRPConfig.ApiCall.Cities.link;
            if let id = cityId {
                path += "/\(id)"
            }
        }else if requestType == .cityWithLocation {
            path = TRPConfig.ApiCall.GetcityByCoordinates.link;
        }
        return path;
    }
    
    override func parameters() -> Dictionary<String, Any>? {
        var params: Dictionary<String, Any> = [:]
        if let location = location {
            params["lat"] = location.lat
            params["lng"] = location.lon
        }
        return params
    }
    
}
