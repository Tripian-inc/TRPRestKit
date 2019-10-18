//
//  TRPQuestionJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 23.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
/// Parent Json parser model for TripQuestion
internal class TRPTripQuestionJsonModel: TRPParentJsonModel {
    
    /// Question datas.
    public var data: [TRPTripQuestionInfoModel]?
    
    private enum CodingKeys: String, CodingKey { case data }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let datas = try? values.decodeIfPresent([TRPTripQuestionInfoModel].self, forKey: .data) {
            self.data = datas
        } else if let mdata = try? values.decodeIfPresent(TRPTripQuestionInfoModel.self, forKey: .data), let convertedData = [mdata] as? [TRPTripQuestionInfoModel] {
            self.data = convertedData
        }
        
        try super.init(from: decoder)
    }
    
}
