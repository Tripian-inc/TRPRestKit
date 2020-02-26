//
//  TRPPlaceInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// This model provide you to use full information of Poi.
public struct TRPPoiInfoModel: Decodable {
    
    /// An Int value. Unique id of Poi
    public var id: Int
    /// An Int value. City Id of Poi
    public var cityId: Int
    /// A String value. Name of poi
    public var name: String
    /// A Float value. Indicates how many stars poi has.
    public var rating: Float?
    /// An Int value. Indicates how many review poi has.
    public var ratingCount: Int?
    /// A String value. Address of poi.
    public var address: String?
    /// An Int value. Indicates level of price between 0 and 4.
    public var price: Int = 0
    /// A String value. Url of web site.
    public var web: String?
    /// A String value. Indicates the hours of operation.
    public var hours: String?
    /// A String value. Phone number of  poi.
    public var phone: String?
    /// A String value. Featured image of poi
    public var image: String?
    /// A String value. Icon name of poi.
    public var icon: String
    /// A TRPCategoryInfoModel array. A poi can have multiple categories.
    public var category = [TRPCategoryInfoModel]()
    /// A TRPCoordinateModel objects. Center coordinate of poi.
    public var coordinate: TRPCoordinateModel
    /// A String value. Sub category of poi such as vegetarian friendly, vegan options, gluten free options.
    public var subCategory: String?
    /// A String value. Description of poi.
    public var description: String?
    
    public var mainCuisines: String?
    public var cuisines: String?
    public var features: String?
    public var narrativeTags: String?
    
    /// A TRPImageOwner object. Indicates who took the photo.
    public var imageOwner: TRPImageOwner?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case cityId = "city_id"
        case rating
        case ratingCount = "rating_count"
        case name
        case address = "address"
        case price
        case web
        case hours
        case phone
        case image
        case icon
        case category
        case coordinate
        case description
        case subCategory = "sub_category"
        case mainCuisisnes = "main_cuisines"
        case cuisines
        case features
        case narrativeTags = "narrative_tags"
        case imageOwner = "image_owner"
    }
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.cityId = try values.decode(Int.self, forKey: .cityId)
        self.rating = try values.decodeIfPresent(Float.self, forKey: .rating)
        self.ratingCount = try values.decodeIfPresent(Int.self, forKey: .ratingCount)
        self.name = try values.decode(String.self, forKey: .name)
        self.address = try values.decodeIfPresent(String.self, forKey: .address)
        self.price = try values.decodeIfPresent(Int.self, forKey: .price) ?? 0
        self.web = try values.decodeIfPresent(String.self, forKey: .web)
        self.hours = try values.decodeIfPresent(String.self, forKey: .hours)
        self.phone = try values.decodeIfPresent(String.self, forKey: .phone)
        self.image = try values.decodeIfPresent(String.self, forKey: .image)
        self.icon = try values.decode(String.self, forKey: .icon)
        self.coordinate = try values.decode(TRPCoordinateModel.self, forKey: .coordinate)
        
        if let categorys = try values.decodeIfPresent([TRPCategoryInfoModel].self, forKey: .category) {
            category = categorys
        }
        if let desk = try values.decodeIfPresent(String.self, forKey: .description) {
            description = desk
        }
        self.subCategory = try values.decodeIfPresent(String.self, forKey: .subCategory)
        self.mainCuisines = try values.decodeIfPresent(String.self, forKey: .mainCuisisnes)
        self.cuisines = try values.decodeIfPresent(String.self, forKey: .cuisines)
        self.features = try values.decodeIfPresent(String.self, forKey: .features)
        self.narrativeTags = try values.decodeIfPresent(String.self, forKey: .narrativeTags)
        
        self.imageOwner = try values.decodeIfPresent(TRPImageOwner.self, forKey: .imageOwner)
    }
    
}
