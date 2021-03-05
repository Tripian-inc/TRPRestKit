//
//  TRPPoiRefInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.02.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPPoiRefInfoModel: Decodable {
    
    /// An Int value. Unique id of a city.
    public var id: Int
    public var name: String
    public var markerCoordinate: TRPCoordinateModel
    public var category: [TRPCategoryInfoModel]
    public var image: TRPImageModel
   
    /// Tag matcher
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case markerCoordinate = "marker_coordinate"
        case image
        case category
    }
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.markerCoordinate = try values.decode(TRPCoordinateModel.self, forKey: .markerCoordinate)
        self.category = try values.decode([TRPCategoryInfoModel].self, forKey: .category)
        self.image = try values.decode(TRPImageModel.self, forKey: .image)
    }
    
}
