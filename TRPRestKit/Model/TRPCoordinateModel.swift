//
//  TRPCoordinateModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

public struct TRPCoordinateModel: Decodable {
    public var lat: Double
    public var lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon = "lng"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        lat = try values.decode(Double.self, forKey: .lat)
        lon = try values.decode(Double.self, forKey: .lon)
    }
}
