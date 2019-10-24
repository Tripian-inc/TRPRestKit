//
//  TRPProblemCategoriesJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 27.03.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPProblemCategoriesJsonModel: TRPParentJsonModel {
    
    internal var datas: [TRPProblemCategoriesInfoModel]?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        datas = try values.decodeIfPresent([TRPProblemCategoriesInfoModel].self, forKey: .data)
        try super.init(from: decoder)
    }
    
}

/// Indicates categories that used to report a error
public struct TRPProblemCategoriesInfoModel: Decodable {
    
    /// An Int valuee. Id of category
    public var id: Int
    /// A String value. Name of category
    public var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    /// Initializes a new object with decoder
    ///
    /// - Parameter decoder: Json decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: TRPProblemCategoriesInfoModel.CodingKeys.id)
        self.name = try values.decode(String.self, forKey: TRPProblemCategoriesInfoModel.CodingKeys.name)
    }
    
}
