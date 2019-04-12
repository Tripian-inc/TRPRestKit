//
//  TRPFavoritesJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 9.10.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPFavoritesJsonModel: TRPParentJsonModel {
    
    internal var data: [TRPFavoritesInfoModel]?;
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let data = try? values.decodeIfPresent(TRPFavoritesInfoModel.self, forKey: .data) {
            self.data = [data] as? [TRPFavoritesInfoModel]
        }else if let datas = try? values.decodeIfPresent([TRPFavoritesInfoModel].self, forKey: .data) {
            self.data = datas
        }
        try super.init(from: decoder);
    }
    
}


public struct TRPFavoritesInfoModel: Decodable{
    
    public var poiId: Int
    public var cityId: Int
    
    private enum CodingKeys: String, CodingKey {
        case poiId = "poi_id"
        case cityId = "city_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.poiId = try values.decode(Int.self, forKey: .poiId)
        self.cityId = try values.decode(Int.self, forKey: .cityId)
    }
}

