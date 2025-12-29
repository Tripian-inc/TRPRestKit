//
//  TRPTourScheduleJsonModel.swift
//  TRPRestKit
//
//  Created by Tripian Inc on 26.12.2025.
//  Copyright © 2025 Tripian Inc. All rights reserved.
//

import Foundation

/// Parent Json parser model for Tour Schedule
public class TRPTourScheduleJsonModel: TRPParentJsonModel {

    /// Tour schedule data
    public var data: TRPTourScheduleModel?

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decodeIfPresent(TRPTourScheduleModel.self, forKey: .data)
        try super.init(from: decoder)
    }
}
