//
//  TRPRoutesResultDaysJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPRoutesResultDaysJsonModel:Decodable {
    
    public let date: String?;
    public let steps: [TRPRoutesResultStepsJsonModel]?
    
    enum CodingKeys: String, CodingKey {
        case date = "date";
        case steps = "steps";
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        date = try values.decodeIfPresent(String.self, forKey: .date);
        steps = try values.decodeIfPresent([TRPRoutesResultStepsJsonModel].self, forKey: .steps);
    }
    
}
