//
//  TRPPlaceInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPPlaceInfoJsonModel: Decodable {
    
    public var id: Int?;
    public var cityId: Int?
    public var rating: Float?;
    public var ratingCount: Int?;
    public var favorite: Bool = false;
    public var duration: String?;
    public var title: String?;
    public var content: String?;
    public var address: String?;
    public var price: String?;
    public var web: String?
    public var hours: String?;
    public var phone: String?;
    public var image: String?;
    public var gallery: [String]?;
    public var icon: String?;
    public var types = [Int]();
    public var tags = [Int]();
    public var coordinate: TRPCoordinateModel?
    public var updateType: TRPUpdateTypeModel = .added
    
    enum CodingKeys: String, CodingKey {
        case id
        case cityId = "city_id"
        case rating
        case ratingCount = "rating_count"
        case favorite
        case duration
        case title
        case content
        case address = "address"
        case price
        case web
        case hours
        case phone
        case image = "img"
        case gallery
        case icon
        case types = "type"
        case tag = "tag"
        case coord
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
        self.title = try values.decodeIfPresent(String.self, forKey: .title);
        self.content = try values.decodeIfPresent(String.self, forKey: .content);
        self.address = try values.decodeIfPresent(String.self, forKey: .address);
        self.price = try values.decodeIfPresent(String.self, forKey: .price);
        self.web = try values.decodeIfPresent(String.self, forKey: .web);
        self.hours = try values.decodeIfPresent(String.self, forKey: .hours);
        self.phone = try values.decodeIfPresent(String.self, forKey: .phone);
        self.image = try values.decodeIfPresent(String.self, forKey: .image);
        self.gallery = try values.decodeIfPresent([String].self, forKey: .gallery);
        self.icon = try values.decodeIfPresent(String.self, forKey: .icon);
        self.coordinate = try values.decodeIfPresent(TRPCoordinateModel.self, forKey: .coord)
        
        //TODO: - SADECE TYPE ID KULLANILIYOR.
        //        {
        //            "id": 3,
        //            "type": "Restaurants",
        //            "description": "Cuisine, brunch, vegetarian, etc."
        //         }
        if let typeObj = try values.decodeIfPresent([TRPPlaceInfoIdsJsonModel].self, forKey: .types) {
            for i in typeObj {
                types.append(i.id)
            }
        }
        
        //TODO: - SADECE TAG ID KULLANILIYOR. BUNA KESİNLİKLE NAME EKLENMELİ
        if let tagObj = try values.decodeIfPresent([TRPPlaceInfoIdsJsonModel].self, forKey: .tag) {
            for i in tagObj {
                tags.append(i.id)
            }
        }
        
        if let updateStr = try values.decodeIfPresent(String.self, forKey: .updateType), let type = TRPUpdateTypeModel.convert(updateStr) {
            updateType = type
        }
    }
    
}

struct TRPPlaceInfoIdsJsonModel: Decodable{
    var id:Int
}
