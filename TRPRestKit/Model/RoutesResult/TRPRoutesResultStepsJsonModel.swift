//
//  TRPRoutesResultStepsJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRoutesResultStepsJsonModel:Decodable {
    
    public var travel: TRPRoutesResultTravelJsonModel?;
    public var place: TRPRoutesResultPlaceJsonModel?;
    public var order: Int?;
    
    enum CodingKeys: String, CodingKey {
        case travel
        case place = "place"
        case order
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        if let p = try values.decode(TRPRoutesResultPlaceJsonModel?.self, forKey: .place), p.id != nil {
            self.place = p;
        }
        
        if let t = try? values.decode(TRPRoutesResultTravelJsonModel.self, forKey: .travel) {
            if t.driving != nil || t.walking != nil {
                self.travel = t;
            }
        }
    }
    
}
