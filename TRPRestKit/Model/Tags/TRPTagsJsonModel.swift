//
//  TRPTagsJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 20.06.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPTagsJsonModel: TRPParentJsonModel {
    
    public var data: [TRPTagsInfoModel]?;
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let datas = try? values.decodeIfPresent([TRPTagsInfoModel].self, forKey: .data) {
            self.data = datas
        }
        try super.init(from: decoder);
    }
    
}
