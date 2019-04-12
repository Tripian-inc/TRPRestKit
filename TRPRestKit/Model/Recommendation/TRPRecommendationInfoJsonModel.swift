//
//  TRPRecommendationInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRecommendationInfoJsonModel: Decodable {
    
    public var id: Int;
    
    private enum CodingKeys: String, CodingKey {
        case id
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decode(Int.self, forKey: .id);
    }
    
}
