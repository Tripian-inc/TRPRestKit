//
//  TRPQuestionOptionsJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 23.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPQuestionOptionsJsonModel: Decodable{
    
    public var id: Int
    public var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    public init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id);
        self.name = try values.decode(String.self, forKey: .name);
    }
}
