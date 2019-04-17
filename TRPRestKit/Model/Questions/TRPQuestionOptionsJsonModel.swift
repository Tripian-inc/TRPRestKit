//
//  TRPQuestionOptionsJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 23.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// Options of a Question.
public struct TRPQuestionOptionsJsonModel: Decodable{
    
    /// An Int value. Unique Id of option.
    public var id: Int
    /// A String value. Name of option.
    public var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id);
        self.name = try values.decode(String.self, forKey: .name);
    }
}
