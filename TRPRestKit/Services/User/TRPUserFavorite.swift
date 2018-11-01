//
//  TRPUserFavorite.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 8.10.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPUserFavorite: TRPRestServices{
    
    public enum Mode {
        case add, get, delete
    }
    private let type: Mode
    private var cityId: Int?
    private var poiId: Int?
    
    //ADD - Remove
    public init(cityId: Int, poiId: Int, type: Mode){
        self.type = type
        self.cityId  = cityId
        self.poiId = poiId
    }
    
    //GET
    public init(cityId: Int) {
        self.type = .get
        self.cityId = cityId
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
            let result = try jsonDecode.decode(TRPFavoritesJsonModel.self, from: data)
            self.Completion?(result, nil, nil);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    override public func requestMode() -> TRPRequestMode {
        if type == .get {
            return .get
        }else if type == .add || type == .delete{
            return .post
        }
        return .get
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.Favorite.link
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
 
    
    public override func parameters() -> Dictionary<String, Any>? {
        if type == .get {
            if let cityId = cityId {
                return ["city_id":"\(cityId)"];
            }
        }else if type == .add || type == .delete{
            if let cityId = cityId, let poi = poiId {
                return ["city_id":"\(cityId)","poi_id": "\(poi)"];
            }
        }
        return nil
    }
}
