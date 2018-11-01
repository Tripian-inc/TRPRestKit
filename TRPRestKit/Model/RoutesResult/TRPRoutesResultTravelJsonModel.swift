//
//  TRPRoutesResultTravelJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRoutesResultTravelJsonModel:Decodable {
    
    var walking: TRPRoutesResultTravelDetailsJsonModel?;
    var driving: TRPRoutesResultTravelDetailsJsonModel?;
    
    enum CodingKeys: String, CodingKey {
        case walking
        case driving
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        walking = try values.decodeIfPresent(TRPRoutesResultTravelDetailsJsonModel.self, forKey: .walking);
        driving = try values.decodeIfPresent(TRPRoutesResultTravelDetailsJsonModel.self, forKey: .driving);
    }
    
}
