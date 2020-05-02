//
//  TRPReactionModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 2.05.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPReactionModel: Decodable {
    
    var id: Int
    var poiId: Int
    var stepId: Int
    var reaction: String?
    var comment: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case poiId = "place_id"
        case stepId = "step_id"
        case reaction
        case comment
    }
    
}
