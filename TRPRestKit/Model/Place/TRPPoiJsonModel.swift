//
//  TRPPlaceJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPPoiJsonModel:TRPParentJsonModel {
    
    public var data: [TRPPoiInfoModel]?;
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let models = try? values.decodeIfPresent([TRPPoiInfoModel].self, forKey: .data) {
            self.data = models
        }else if let model = try? values.decodeIfPresent(TRPPoiInfoModel.self, forKey: .data), let data = [model] as? [TRPPoiInfoModel]{
            self.data = data;
        }
        try super.init(from: decoder);
    }
}
