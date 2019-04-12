//
//  TRPRoutesResultTravelDetailsJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRoutesResultTravelDetailsJsonModel:Decodable {
    
    var preferred:Bool?;
    var time: String?;
    
    private enum CodingKeys: String, CodingKey {
        case preferred
        case time
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        preferred = try values.decodeIfPresent(Bool.self, forKey: .preferred);
        time = try values.decodeIfPresent(String.self, forKey: .time);
    }
    
}
