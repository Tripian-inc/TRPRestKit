//
//  TRPCompanionsJsonModel.swift
//  TRPRestKit
//
//  Created by Rozeri Dağtekin on 6/26/19.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPCompanionsJsonModel: TRPParentJsonModel {
    
    public var data: [TRPCompanionModel]?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("----- TRPCompanionModel ----")
        if let data = try? values.decodeIfPresent(TRPCompanionModel.self, forKey: .data) {
            print("TRPCompanionModel is object")
            self.data = [data] as? [TRPCompanionModel]
        }else if let datas = try? values.decodeIfPresent([TRPCompanionModel].self, forKey: .data) {
            print("TRPCompanionModel is Array")
            self.data = datas
        }else {
            self.data = []
        }

        try super.init(from: decoder)
    }
}
