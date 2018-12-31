//
//  TRPQuestionInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 23.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPTripQuestionInfoModel: Decodable {
    
    public var id: Int?;
    public var skippable: Bool?;
    public var selectMultiple: Bool?
    public var name: String?;
    public var options:[TRPQuestionOptionsJsonModel]?;
    
    enum CodingKeys: String, CodingKey {
        case id
        case skippable
        case selectMultiple = "select_multiple"
        case name
        case options
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
        self.skippable = try values.decodeIfPresent(Bool.self, forKey: .skippable)
        print("SKIPPABLE \(skippable)")
        self.selectMultiple = try values.decodeIfPresent(Bool.self, forKey: .selectMultiple)
        self.name = try values.decodeIfPresent(String.self, forKey: .name);
        self.options = try values.decodeIfPresent([TRPQuestionOptionsJsonModel].self, forKey: .options);
    }
    
}
