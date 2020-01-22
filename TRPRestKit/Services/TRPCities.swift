//
//  TRPCities.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 2.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit
public class TRPCities: TRPRestServices {
    
    private enum RequestType {
        case allCities
        case cityWithId
        case cityWithLocation
    }
    
    private var cityId: Int?
    private var requestType: RequestType = RequestType.allCities
    private var location: TRPLocation?
    public var limit = 50
    
    public override init() {}
    
    public init(cityId: Int) {
        self.requestType = .cityWithId
        self.cityId = cityId
    }
    
    public init(location: TRPLocation) {
        self.requestType = .cityWithLocation
        self.location = location
    }
    
    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.completion?(nil, error, nil)
            return
        }
        guard let data = data else {
            self.completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        let jsonDecode = JSONDecoder()
        do {
            let result = try jsonDecode.decode(TRPCityJsonModel.self, from: data)
            let pag = paginationController(parentJson: result)
            self.completion?(result, nil, pag)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }
    
    public override func path() -> String {
        var path = ""
        
        if requestType == .allCities || requestType == .cityWithId {
            path = TRPConfig.ApiCall.cities.link
            if let id = cityId {
                path += "/\(id)"
            }
        } else if requestType == .cityWithLocation {
            path = TRPConfig.ApiCall.getcityByCoordinates.link
        }
        return path
    }
    
    override public func parameters() -> [String: Any]? {
        var params: [String: Any] = [:]
        if let location = location {
            params["coordinate"] = "\(location.lat),\(location.lon)"
        }
        params["limit"] = limit
        return params
    }
    
}
