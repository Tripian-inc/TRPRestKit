//
//  TRPPlace.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 7.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit
internal class TRPPlace: TRPRestServices {
    
    private enum FetchType {
        case withCityId
        case withPlacesId
        case withLocation
    }
    
    var placeIds: [Int]?;
    var cities: [Int]?;
    var limit: Int = 25;
    var typeId: Int? = nil
    private var location: TRPLocation?
    private var distance: Double?
    private var status: FetchType = FetchType.withCityId
    
    internal override init() {}
    
    internal init(ids: [Int], cityId: Int) {
        self.placeIds = ids;
        self.cities = [cityId]
        status = .withPlacesId
    }
    
    internal init(cities:[Int]){
        self.cities = cities;
        status = .withCityId
    }
    
    internal init(location: TRPLocation,
                  distance:Double? = nil,
                  typeId: Int? = nil) {
        self.location = location
        self.distance = distance
        self.typeId = typeId
        status = .withLocation
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
            let result = try jsonDecode.decode(TRPPoiJsonModel.self, from: data)
            let pag = paginationController(parentJson: result)
            self.Completion?(result, nil, pag);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    override func parameters() -> Dictionary<String, Any>? {
        var params: [String: Any] = [:]
        if status == .withCityId {
            if let cities = cities {
                let citiesList = cities.toString()
                params["city_id"] = citiesList
                params["limit"] = String(limit)
            }
        }else if status == .withPlacesId {
            if let places = placeIds, let cities = cities, let city = cities.first {
                let placesList = places.toString()
                params["city_id"] = city
                params["q"] = "id:" + placesList
            }
        }else if status == .withLocation {
            if let location = location {
                params["coordinate"] = "\(location.lat),\(location.lon)"
                
                if let distance = distance {
                    params["distance"] = distance
                }
                // TODO: typeid eklenecek
                if let typeId = typeId {
                    params["poi_categories"] = typeId
                }
            }
        }
        if params.count > 0 {
            params["limit"] = limit
        }
        return params
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.Poi.link;
    }
    
}
