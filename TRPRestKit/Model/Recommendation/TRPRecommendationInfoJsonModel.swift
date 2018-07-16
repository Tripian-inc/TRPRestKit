//
//  TRPRecommendationInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRecommendationInfoJsonModel: Decodable {
    
    public var id: Int?;
    public var total: Float?;
    public var score: TRPRecommendationScoreJsonModel?
    
    enum CodingKeys: String, CodingKey {
        case id
        case total
        case score
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decodeIfPresent(Int.self, forKey: .id);
        self.total = try values.decodeIfPresent(Float.self, forKey: .total);
        self.score = try values.decodeIfPresent(TRPRecommendationScoreJsonModel.self, forKey: .score);
    }
    
}
