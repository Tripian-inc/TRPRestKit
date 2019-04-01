//
//  TRPProblemCategoriesJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 27.03.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPProblemCategoriesJsonModel: TRPParentJsonModel {
    
    public var datas: [TRPProblemCategoriesInfoModel]?;
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        datas = try values.decodeIfPresent([TRPProblemCategoriesInfoModel].self, forKey: .data)
        try super.init(from: decoder)
    }
    
}


public struct TRPProblemCategoriesInfoModel: Decodable {
    
    public var id: Int
    public var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: TRPProblemCategoriesInfoModel.CodingKeys.id)
        self.name = try values.decode(String.self, forKey: TRPProblemCategoriesInfoModel.CodingKeys.name)
    }
    
}
