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
    
    private enum FetchType {
        case withCityId
        case withPlacesId
        case withLocation
        case withSearchText
        case withCityType
    }
    
    var placeIds: [Int]?
    var cities: [Int]?
    var limit: Int = 25
    var typeId: Int?
    var typeIds: [Int]?
    
    private var location: TRPLocation?
    private var bounds: LocationBounds?
    private var distance: Float?
    private var status: FetchType = FetchType.withCityId
    private var searchText: String?
    public var cityId: Int?
    
    internal override init() {}
    
    internal init(ids: [Int], cityId: Int) {
        self.placeIds = ids
        self.cities = [cityId]
        status = .withPlacesId
    }
   
    internal init(cities: [Int]) {
        self.cities = cities
        status = .withCityId
    }
    
    internal init(location: TRPLocation,
                  distance: Float? = nil,
                  typeId: Int? = nil,
                  typeIds: [Int]? = nil) {
        self.location = location
        self.distance = distance
        self.typeId = typeId
        self.typeIds = typeIds
        status = .withLocation
    }
    
    //Bir alan içinde Text bazlı poi listesi için kullanılır.
    internal init(location: TRPLocation? = nil,
                  searchText: String,
                  cityId: Int?,
                  bounds: LocationBounds?) {
        self.location = location
        self.searchText = searchText
        self.cityId = cityId
        self.bounds = bounds
        status = .withSearchText
    }
    
    internal init(cityId: Int?, typeIds: [Int]?) {
           self.typeIds = typeIds
           self.cityId = cityId
           status = .withCityType
    }
    
    override func parameters() -> [String: Any]? {
        var params: [String: Any] = [:]
        if status == .withCityId {
            params = getParamsWithCityId()
        } else if status == .withPlacesId {
            params = getParamsWithPlacesId()
        } else if status == .withLocation {
            params = getParamsWithLocation()
        } else if status == .withSearchText {
            params = getParamsWithSearchText()
        } else if status == .withCityType {
            params = getParamsWithCityType()
        }
        
        if params.count > 0 {
            params["limit"] = limit
        }
        return params
    }
    
    private func getParamsWithCityId() -> [String: Any] {
        var params: [String: Any] = [:]
        if let cities = cities {
            let citiesList = cities.toString()
            params["city_id"] = citiesList
            params["limit"] = String(limit)
        }
        return params
    }
    
    private func getParamsWithPlacesId() -> [String: Any] {
        var params: [String: Any] = [:]
        if let places = placeIds, let cities = cities, let city = cities.first {
            let placesList = places.toString()
            params["city_id"] = city
            params["poi_ids"] = placesList
        }
        return params
    }
    
    private func getParamsWithLocation() -> [String: Any] {
        var params: [String: Any] = [:]
        if let location = location {
            params["coordinate"] = "\(location.lat),\(location.lon)"
            
            if let distance = distance {
                params["distance"] = distance
            }
            if let typeId = typeId {
                params["poi_categories"] = typeId
            }
            if let typeIds = typeIds {
                if typeIds.count > 0 {
                    params["poi_categories"] = typeIds.toString()
                }
                
            }
            if let cityId = cityId {
                params["city_id"] = cityId
            }
        }
        return params
    }
    
    private func getParamsWithSearchText() -> [String: Any] {
        var params: [String: Any] = [:]
        if let cityId = cityId {
            params["city_id"] = cityId
        }
        if let searchText = searchText {
            params["search"] = searchText
        }
        if let location = location {
            params["coordinate"] = "\(location.lat),\(location.lon)"
        }
        if let bounds = bounds {
            params["bounds"] = "\(bounds.northWest.lat),\(bounds.southEast.lat),\(bounds.northWest.lon),\(bounds.southEast.lon)"
        }
        return params
    }
    
    private func getParamsWithCityType() -> [String: Any] {
        var params: [String: Any] = [:]
        if let cityId = cityId {
            params["city_id"] = cityId
        }
        if let typeIds = typeIds {
            params["poi_categories"] = typeIds.toString()
        }
        return params
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.poi.link
    }
    
}
