//
//  TRPCities.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 2.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit

public class TRPCities: TRPRestServices<TRPCityJsonModel> {
    
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
    //Fixme: Lokasyon ile sehir arama aktif değil
    public init(location: TRPLocation) {
        self.requestType = .cityWithLocation
        self.location = location
    }
    
    public override func path() -> String {
        var path = ""
        
        if requestType == .allCities || requestType == .cityWithId {
            path = TRPConfig.ApiCall.city.link
            if let id = cityId {
                path += "/\(id)"
            }
        } else if requestType == .cityWithLocation {
            //path = TRPConfig.ApiCall.getcityByCoordinates.link
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
    
    override var isPagination: Bool {
        return true
    }
    
}
