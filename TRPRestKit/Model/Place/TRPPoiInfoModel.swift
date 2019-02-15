//
//  TRPPlaceInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPPoiInfoModel: Decodable {
    
    public var id: Int?;
    public var cityId: Int?
    public var rating: Float?;
    public var ratingCount: Int?;
    public var favorite: Bool = false;
    public var duration: String?;
    public var name: String?;
    public var content: String?;
    public var address: String?;
    public var price: Int = 0
    public var web: String?
    public var hours: String?;
    public var phone: String?;
    public var image: String?;
    public var gallery: [String]?;
    public var icon: String?;
    // TODO: add category
    public var category = [TRPCategoryInfoModel]()
    public var tags = [TRPPoiTagInfoModel]();
    public var coordinate: TRPCoordinateModel?
    public var updateType: TRPUpdateTypeModel = .added
    
    enum CodingKeys: String, CodingKey {
        case id
        case cityId = "city_id"
        case rating
        case ratingCount = "rating_count"
        case favorite
        case duration
        case name
        case content
        case address = "address"
        case price
        case web
        case hours
        case phone
        case image = "image"
        case gallery
        case icon
        case category
        case tag = "tag"
        case coordinate
        case updateType
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decodeIfPresent(Int.self, forKey: .id);
        
        self.cityId = try values.decodeIfPresent(Int.self, forKey: .cityId);
        self.rating = try values.decodeIfPresent(Float.self, forKey: .rating);
        self.ratingCount = try values.decodeIfPresent(Int.self, forKey: .ratingCount);
        // TODO: BOOL AÇILACAK
        //self.favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite) ?? false
        
        self.duration = try values.decodeIfPresent(String.self, forKey: .duration);
        self.name = try values.decodeIfPresent(String.self, forKey: .name);
        self.content = try values.decodeIfPresent(String.self, forKey: .content);
        self.address = try values.decodeIfPresent(String.self, forKey: .address);
        self.price = try values.decodeIfPresent(Int.self, forKey: .price) ?? 0
        self.web = try values.decodeIfPresent(String.self, forKey: .web);
        self.hours = try values.decodeIfPresent(String.self, forKey: .hours);
        self.phone = try values.decodeIfPresent(String.self, forKey: .phone);
        self.image = try values.decodeIfPresent(String.self, forKey: .image);
        self.gallery = try values.decodeIfPresent([String].self, forKey: .gallery);
        self.icon = try values.decodeIfPresent(String.self, forKey: .icon);
        self.coordinate = try values.decodeIfPresent(TRPCoordinateModel.self, forKey: .coordinate)
        
        if let categorys = try values.decodeIfPresent([TRPCategoryInfoModel].self, forKey: .category) {
            category = categorys
        }
        
        //TODO: - SADECE TAG ID KULLANILIYOR. BUNA KESİNLİKLE NAME EKLENMELİ
        if let tagObj = try values.decodeIfPresent([TRPPoiTagInfoModel].self, forKey: .tag) {
            tags = tagObj
        }
        
        if let updateStr = try values.decodeIfPresent(String.self, forKey: .updateType), let type = TRPUpdateTypeModel.convert(updateStr) {
            updateType = type
        }
    }
    
}

public struct TRPPoiTagInfoModel: Decodable{
    public var id:Int
    public var name: String
}
