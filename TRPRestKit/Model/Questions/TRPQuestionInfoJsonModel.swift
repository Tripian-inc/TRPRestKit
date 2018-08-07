//
//  TRPQuestionInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 23.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPQuestionInfoJsonModel: Decodable {
    
    public var id: Int?;
    public var skippable: Bool?;
    public var inputType: Bool?
    public var name: String?;
    public var options:[TRPQuestionOptionsJsonModel]?;
    
    enum CodingKeys: String, CodingKey {
        case id
        case skippable
        case inputType = "input_type"
        case name
        case options
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self);
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
        let skip = try values.decodeIfPresent(Int.self, forKey: .skippable)
        if skip != nil && skip! == 1 {
            self.skippable = true;
        }else {
            self.skippable = false;
        }
        let input = try values.decodeIfPresent(Int.self, forKey: .inputType)
        if input != nil && input! == 1 {
            self.inputType = true;
        }else {
            self.inputType = false;
        }
        self.name = try values.decodeIfPresent(String.self, forKey: .name);
        self.options = try values.decodeIfPresent([TRPQuestionOptionsJsonModel].self, forKey: .options);
        
    }
    
}
