//
//  TRPCoordinateModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

public struct TRPAdditionalDataModel: Codable {
    
    public var bookingUrl: String?
    public var productId: String?
    public var providerId: Int?
    public var currency: String?
    public var version: String?
    public var tagIds: [Int]?
    public var tripianPois: [String]?  // veya uygun tip
    public var price: Double?
}
