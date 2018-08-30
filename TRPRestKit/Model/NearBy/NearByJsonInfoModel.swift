//
//  NearByJsonInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPNearByInfoModel: Decodable {
    var id: Int
    var hash: String
    var placeId: Int
    var steps: TRPProgramStep?
    
    //TODO: - preferences eklenecek
    enum CodingKeys: String, CodingKey {
        case id
        case hash
        case placeId = "place_id"
        case steps = "programstep"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decode(Int.self, forKey: .id)
        self.hash = try values.decode(String.self, forKey: .hash)
        self.placeId = try values.decode(Int.self, forKey: .placeId)
        
        if let steps = try? values.decodeIfPresent(TRPProgramStep.self, forKey: .steps) {
            self.steps = steps
        }
        
    }
}
