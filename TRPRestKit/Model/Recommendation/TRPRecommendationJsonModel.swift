//
//  TRPRecommendationJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPRecommendationJsonModel: TRPParentJsonModel {
    
    public var data: [TRPRecommendationInfoJsonModel]?;
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decodeIfPresent([TRPRecommendationInfoJsonModel].self, forKey: .data)
        try super.init(from: decoder);
    }
}
