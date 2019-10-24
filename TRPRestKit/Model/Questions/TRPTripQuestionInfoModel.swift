//
//  TRPQuestionInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 23.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// This model provide you to use full information of Question to creating a trip.
public struct TRPTripQuestionInfoModel: Decodable {
    
    /// An Int value. Unique Id of question.
    public var id: Int?
    /// A Bool value. Indicates that the question can be skipped without an answer.
    public var skippable: Bool?
    /// A Bool value. A Question can be multiple answer.
    public var selectMultiple: Bool?
    /// A String value. Name of question.
    public var name: String?
    
    /// A TRPQuestionOptionsJsonModel object. Options of a question.
    public var options: [TRPQuestionOptionsJsonModel]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case skippable
        case selectMultiple = "select_multiple"
        case name
        case options
    }
    
    /// Json to Object converter
    ///
    /// - Parameter decoder: Json Decoder Object
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
        self.skippable = try values.decodeIfPresent(Bool.self, forKey: .skippable)
        self.selectMultiple = try values.decodeIfPresent(Bool.self, forKey: .selectMultiple)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.options = try values.decodeIfPresent([TRPQuestionOptionsJsonModel].self, forKey: .options)
    }
    
}
