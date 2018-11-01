//
//  TRPProgramStepJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPProgramStepJsonModel: TRPParentJsonModel{
    
    public var data: TRPPlanPointInfoModel?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let data = try? values.decodeIfPresent(TRPPlanPointInfoModel.self, forKey: .data) {
            self.data = data
        }
        try super.init(from: decoder);
    }
}
