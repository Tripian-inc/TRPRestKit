//
//  TRPUserMeJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPUserMeJsonModel: TRPParentJsonModel{
    
    public var data: TRPUserMeInfoModel;
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decode(TRPUserMeInfoModel.self, forKey: .data)
        try super.init(from: decoder);
    }
}
