//
//  TRPTagsInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 20.06.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPTagsInfoModel:NSObject, Decodable {
    
    public var id: Int?;
    public var name: String?;
    public var updateType: TRPUpdateTypeModel = .added
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case updateType
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decodeIfPresent(Int.self, forKey: .id);
        self.name = try values.decodeIfPresent(String.self, forKey: .name);
        
        if let updateStr = try values.decodeIfPresent(String.self, forKey: .updateType), let type = TRPUpdateTypeModel.convert(updateStr) {
            updateType = type
        }
    }
}
