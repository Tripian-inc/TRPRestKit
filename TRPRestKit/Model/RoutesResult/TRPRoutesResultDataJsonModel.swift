//
//  TRPRoutesResultDataJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRoutesResultDataJsonModel: Decodable {
    
    public let days: [TRPRoutesResultDaysJsonModel]?;
    public var params: TRPRoutesResultParamsJsonModel?;
    
    enum CodingKeys: String, CodingKey {
        case days = "days"
        case params
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        days = try values.decodeIfPresent([TRPRoutesResultDaysJsonModel].self, forKey: .days);
        if days == nil {
            return
        }
        params = try values.decodeIfPresent(TRPRoutesResultParamsJsonModel.self, forKey: .params);
    }
    
}
