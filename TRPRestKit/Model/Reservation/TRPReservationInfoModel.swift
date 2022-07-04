//
//  TRPReservationInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 14.07.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPReservationInfoModel: Decodable {
    
    public let id: Int
    public let key: String
    //let value: Any?
    public let provider: String
    public let tripHash: String?
    public let poiID: Int?
    public let createdAt: String
    public var updatedAt: String?
    public var yelpModel: TRPYelpInfoModel?
    public var gygModel: TRPGygInfoModel?
    
    enum CodingKeys: String, CodingKey {
        case id, key, provider
        case tripHash = "tripHash"
        case poiID = "poiId"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case value = "value"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.key = try values.decode(String.self, forKey: .key)
        self.provider = try values.decode(String.self, forKey: .provider)
        self.tripHash = try values.decodeIfPresent(String.self, forKey: .tripHash)
        self.poiID = try values.decodeIfPresent(Int.self, forKey: .poiID)
        self.createdAt = try values.decode(String.self, forKey: .createdAt)
        self.updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        
        if let yelp = try? values.decodeIfPresent(TRPYelpInfoModel.self, forKey: .value) {
            yelpModel = yelp
        }
        
        if let gyg = try? values.decodeIfPresent(TRPGygInfoModel.self, forKey: .value) {
            gygModel = gyg
        }
        
        do {
            if let gyg = try values.decodeIfPresent(TRPGygInfoModel.self, forKey: .value) {
                gygModel = gyg
            }
        }catch {
            print("[Error] \(error)")
        }
        
    }
    
}

public struct TRPYelpInfoModel: Codable {
    public let confirmURL: String
    public let reservationID: String
    public let restaurantImage: String
    public let restaurantName: String
    public let reservationDetail: TRPYelpReservationDetailInfoModel?
    
    enum CodingKeys: String, CodingKey {
        case confirmURL = "confirmUrl"
        case reservationID = "reservationId"
        case restaurantImage = "restaurantImage"
        case restaurantName = "restaurantName"
        case reservationDetail = "reservationDetails"
    }
}

// MARK: - ReservationStatus
public struct TRPYelpReservationDetailInfoModel: Codable {
    
    public let businessID: String
    public let covers: Int
    public let time, holdID, firstName, phone: String
    public let date, email, uniqueID, lastName: String
    
    enum CodingKeys: String, CodingKey {
        case businessID = "businessId"
        case covers, time
        case holdID = "holdId"
        case firstName, phone, date, email
        case uniqueID = "uniqueId"
        case lastName
    }
    
}
