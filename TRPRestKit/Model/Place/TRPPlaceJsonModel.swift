//
//  TRPPlaceJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPPlaceJsonModel:TRPParentJsonModel {
    
    public var data: [TRPPlaceInfoJsonModel]?;
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let models = try? values.decodeIfPresent(Array<TRPPlaceInfoJsonModel>.self, forKey: .data) {
            self.data = models
        }else if let model = try? values.decodeIfPresent(TRPPlaceInfoJsonModel.self, forKey: .data), let data = [model] as? [TRPPlaceInfoJsonModel]{
            self.data = data;
        }
        try super.init(from: decoder);
    }
}