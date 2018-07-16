//
//  TRPGRoutesResultWalkDriveJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPGRoutesResultWalkDriveJsonModel: Decodable{
    
    var walking: [TRPGRoutesResultInfoJsonModel]?;
    var driving: [TRPGRoutesResultInfoJsonModel]?;
    
    enum CodingKeys: String, CodingKey {
        case walking = "walking";
        case driving = "driving";
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        walking = try values.decodeIfPresent([TRPGRoutesResultInfoJsonModel].self, forKey: .walking);
        driving = try values.decodeIfPresent([TRPGRoutesResultInfoJsonModel].self, forKey: .driving);
    }
    
}
