//
//  TRPBookingModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 26.02.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPBookingInfoModel: Decodable {
    var name: String
    var url: String
    var provider: TRPPoiBookingProvider
}

public struct TRPPoiBookingProvider: Decodable {
    var name: String
}
