//
//  TRPPlace.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 7.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit
internal class TRPPoiService: TRPRestServices<TRPPoiJsonModel> {
    

    
    //Must
    var cityId: Int?
    var coordinate: TRPLocation?
    
    //Optinal
    var searchText: String?
    var placeIds: [Int]?
    var mustTryIds: [Int]?
    var poiCategories: [Int]?
    var distance: Float?
    var bounds: LocationBounds?
    var limit: Int = 25
    
    
    
    internal override init() {}
    
    
    
    internal init(cityId: Int) {
        self.cityId = cityId
    }
    
    internal init(coordinate: TRPLocation) {
        self.coordinate = coordinate
    }
    
    
    override func parameters() -> [String: Any]? {
        return getParameters()
    }
    
    
    private func getParameters() -> [String: Any] {
        var params: [String: Any] = [:]
        
        //City
        if let cityId = cityId {
            params["city_id"] = cityId
        }
        
        
        //Coordinate
        if let location = coordinate {
            params["coordinate"] = "\(location.lat),\(location.lon)"
        }
        
        if let places = placeIds, places.count > 0 {
            params["poi_ids"] = places
        }
        
        
        if let searchText = searchText {
            params["search"] = searchText
        }

        if let bounds = bounds {
            params["bounds"] = "\(bounds.northEast.lat),\(bounds.southWest.lat),\(bounds.northEast.lon),\(bounds.southWest.lon)"
        }
        
        if let typeIds = poiCategories, typeIds.count > 0 {
            params["poi_categories"] = typeIds.toString()
        }
        
        if let mustTries = mustTryIds {
            params["must_try_ids"] = mustTries.toString()
        }
        
        if let distance = distance {
            params["distance"] = distance
        }
        
        params["limit"] = String(limit)
        
        return params
    }
    
    
    public override func path() -> String {
        return TRPConfig.ApiCall.poi.link
    }
    
}
