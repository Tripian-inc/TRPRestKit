//
//  TRPCityInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPCityInfoModel:NSObject, Decodable {
    
    public var id: Int?
    public var name: String?
    public var coordinate: TRPCoordinateModel?
    public var country: TRPCountryJsonModel?
    public var updateType: TRPUpdateTypeModel = .added
    public var image: String?
    public var rock: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "cityname"
        case coord
        case country
        case updateType
        case image
        case rock
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decodeIfPresent(Int.self, forKey: .id);
        self.name = try values.decodeIfPresent(String.self, forKey: .name);
        self.image = try values.decodeIfPresent(String.self, forKey: .image)
        self.coordinate = try values.decodeIfPresent(TRPCoordinateModel.self, forKey: .coord)
        self.country = try values.decodeIfPresent(TRPCountryJsonModel.self, forKey: .country);
        self.rock = try values.decodeIfPresent(String.self, forKey: .rock)
        if let updateStr = try values.decodeIfPresent(String.self, forKey: .updateType), let type = TRPUpdateTypeModel.convert(updateStr) {
            updateType = type
        }
    }
    
}