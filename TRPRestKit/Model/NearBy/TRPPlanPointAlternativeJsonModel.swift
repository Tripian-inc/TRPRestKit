//
//  NearByJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPPlanPointAlternativeJsonModel: TRPParentJsonModel {
    
    internal var data: [TRPPlanPointAlternativeInfoModel]?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let datas = ((try? values.decodeIfPresent([TRPPlanPointAlternativeInfoModel].self, forKey: .data)) as [TRPPlanPointAlternativeInfoModel]??) {
            self.data = datas
        } else if let infoModel = ((try? values.decodeIfPresent(TRPPlanPointAlternativeInfoModel.self, forKey: .data)) as TRPPlanPointAlternativeInfoModel??) {
            self.data = [infoModel] as? [TRPPlanPointAlternativeInfoModel]
        }
        
        try super.init(from: decoder)
    }
}
