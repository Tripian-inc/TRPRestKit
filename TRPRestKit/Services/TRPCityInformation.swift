//
//  TRPCities.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 2.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit

internal class TRPCityInformation: TRPRestServices<TRPGenericParser<TRPCityInformationDataJsonModel>> {
    
    private var cityId: Int = -1
    
    public override init() {}
    
    public init(cityId: Int) {
        self.cityId = cityId
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.city.link
        path += "/\(cityId)"
        path += "/information"
        return path
    }
    
//    override public func parameters() -> [String: Any]? {
//        var params: [String: Any] = [:]
//        if let location = location {
//            params["coordinate"] = "\(location.lat),\(location.lon)"
//        }
//        if let limit = limit {
//            params["limit"] = limit
//        }
//        return params
//    }
    
}
