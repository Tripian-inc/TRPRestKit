//
//  TRPQuestionOptionsJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 23.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPQuestionOptionsJsonModel: Decodable{
    public var id: Int?
    public var name: String?;
    public var keywords = [String]();
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case keywords
    }
    
    public init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(Int.self, forKey: .id);
        self.name = try values.decodeIfPresent(String.self, forKey: .name);
        self.keywords = try values.decodeIfPresent([String].self, forKey: .keywords) ?? [];
    }
}
