//
//  TRPTypeJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPTypeJsonModel: TRPParentJsonModel {
    
    public var data: [TRPTypeInfoJsonModel]?;
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let datas = try? values.decodeIfPresent([TRPTypeInfoJsonModel].self, forKey: .data) {
            self.data = datas;
        }else if let data = try? values.decodeIfPresent(TRPTypeInfoJsonModel.self, forKey: .data), let newAr = [data] as? [TRPTypeInfoJsonModel]{
            self.data = newAr;
        }
        
        try super.init(from: decoder);
    }
}
