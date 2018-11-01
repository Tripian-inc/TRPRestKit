//
//  TRPRoutesTimeJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
struct TRPRoutesTimeJsonModel: Decodable {
    var date: String?;
    var timeZoneType: Int?;
    var timeZone: String?;
    
    enum CodingKeys: String, CodingKey {
        case date
        case timeZoneType = "timezone_type"
        case timeZone = "timezone"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.date = try values.decodeIfPresent(String.self, forKey: .date)
        self.timeZoneType = try values.decodeIfPresent(Int.self, forKey: .timeZoneType)
        self.timeZone = try values.decodeIfPresent(String.self, forKey: .timeZone)
    }
}
