//
//  TRPPoiAddRouteJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 23.11.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPPoiAddRouteJsonModel: TRPParentJsonModel{
    
    public var data: TRPPoiAddRouteInfoModel
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode(TRPPoiAddRouteInfoModel.self, forKey: .data)
        try super.init(from: decoder);
    }
    
}
