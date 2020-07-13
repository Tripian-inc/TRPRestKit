//
//  TRPBookingModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 26.02.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPBookingInfoModel: Decodable {
    
    var providerId: Int?
    var providerName: String?
    var product: TRPBookingProductInfoModel?
    
    private enum CodingKeys: String, CodingKey {
        case providerId = "provider_id"
        case providerName = "provider_name"
        case product
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        providerId = try values.decodeIfPresent(Int.self, forKey: .providerId)
        providerName = try values.decodeIfPresent(String.self, forKey: .providerName)
        product = try values.decodeIfPresent(TRPBookingProductInfoModel.self, forKey: .product)
        
    }
}

public struct TRPBookingProductInfoModel: Decodable {
    
    var id: String?
    var title: String?
    var additionalData: [String]?
    var url: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case additionalData = "additional_data"
    }
}
