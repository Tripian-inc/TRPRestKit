//
//  TRPProgramStepJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPProgramStepJsonModel: TRPParentJsonModel{
    
    internal var data: TRPPlanPointInfoModel?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let data = try? values.decodeIfPresent(TRPPlanPointInfoModel.self, forKey: .data) {
            self.data = data
        }
        try super.init(from: decoder);
    }
}
