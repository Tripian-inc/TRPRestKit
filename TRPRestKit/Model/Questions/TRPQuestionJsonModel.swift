//
//  TRPQuestionJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 23.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPQuestionJsonModel: TRPParentJsonModel {
    
    public var data: [TRPQuestionInfoJsonModel]?;
    
    enum CodingKeys: String, CodingKey { case data }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        data = try values.decodeIfPresent([TRPQuestionInfoJsonModel].self, forKey: .data)
        try super.init(from: decoder);
    }
    
}
