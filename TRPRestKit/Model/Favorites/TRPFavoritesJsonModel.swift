//
//  TRPFavoritesJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 9.10.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// Parent Json parser model for City
internal class TRPFavoritesJsonModel: TRPParentJsonModel {
    
    ///Favorite's list
    internal var data: [TRPFavoritesInfoModel]?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        /*do {
            self.data = try values.decodeIfPresent([TRPFavoritesInfoModel].self, forKey: .data)
        }catch DecodingError.typeMismatch {
            do {
                if let singleData = try values.decodeIfPresent(TRPFavoritesInfoModel.self, forKey: .data) {
                    self.data = [singleData]
                }
            }
        }*/
        /*if let mData = try? values.decodeIfPresent([TRPFavoritesInfoModel]?.self, forKey: .data) {
            print("ARRAY")
            self.data = mData
        }else if let kData = try? values.decodeIfPresent(TRPFavoritesInfoModel?.self, forKey: .data) {
            print("OBJECT")
            self.data = [kData] as? [TRPFavoritesInfoModel]
        }*/
        
        if let data = try? values.decodeIfPresent(TRPFavoritesInfoModel.self, forKey: .data) {
            self.data = [data] as? [TRPFavoritesInfoModel]
        } else if let datas = try? values.decodeIfPresent([TRPFavoritesInfoModel].self, forKey: .data) {
            self.data = datas
        }
        try super.init(from: decoder)
    }
    
}

/// This model provides you information of Favorites Poi.
public struct TRPFavoritesInfoModel: Decodable {
    
    /// An Int value. Unique id of a poi.
    public var poiId: Int
    
    /// An Int value. Id of city where the poi is located.
    public var cityId: Int
    
    private enum CodingKeys: String, CodingKey {
        case poiId = "poi_id"
        case cityId = "city_id"
    }
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.poiId = try values.decode(Int.self, forKey: .poiId)
        self.cityId = try values.decode(Int.self, forKey: .cityId)
    }
}
