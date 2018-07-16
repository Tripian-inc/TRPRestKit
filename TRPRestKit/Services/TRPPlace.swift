//
//  TRPPlace.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 7.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPPlace: TRPRestServices {
    
    var placeIds: [Int]?;
    var cities: [Int]?;
    var limit: Int = 25;
    internal override init() {}
    
    internal init(ids: [Int]) {
        self.placeIds = ids;
    }
    
    internal init(cities:[Int]){
        self.cities = cities;
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
            let result = try jsonDecode.decode(TRPPlaceJsonModel.self, from: data)
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    override func parameters() -> Dictionary<String, Any>? {
        if let cities = cities {
            let citiesList = cities.toString()
            return ["q":"city_id:" + citiesList,"limit":String(limit)]
        }else if let places = placeIds {
            let placesList = places.toString()
            return ["q":"id:" + placesList]
            
        }
        return nil
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.Places.link;
    }
    
}
