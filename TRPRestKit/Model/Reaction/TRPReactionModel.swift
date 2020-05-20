//
//  TRPReactionModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 2.05.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPReactionModel: Decodable {
    
    public var id: Int
    public var poiId: Int
    public var stepId: Int
    public var reaction: String?
    public var comment: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case poiId = "poi_id"
        case stepId = "step_id"
        case reaction
        case comment
    }
    
}