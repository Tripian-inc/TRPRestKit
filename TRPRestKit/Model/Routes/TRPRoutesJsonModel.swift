//
//  TRPRoutesJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPRoutesJsonModel: TRPParentJsonModel {
    
    public var data: TRPRoutesInfoJsonModel?;
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decodeIfPresent(TRPRoutesInfoJsonModel.self, forKey: .data)
        try super.init(from: decoder);
    }
    
}
