//
//  TRPReservationInfoModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 14.07.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPReservationInfoModel: Decodable {
    
    let id: Int
    let key: String
    //let value: Any?
    let provider, tripHash: String
    let poiID: Int
    let createdAt: String
    var updatedAt: String?
    var yelpModel: TRPYelpInfoModel?
    
    enum CodingKeys: String, CodingKey {
        case id, key, provider
        case tripHash = "trip_hash"
        case poiID = "poi_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case value = "value"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.key = try values.decode(String.self, forKey: .key)
        self.provider = try values.decode(String.self, forKey: .provider)
        self.tripHash = try values.decode(String.self, forKey: .tripHash)
        self.poiID = try values.decode(Int.self, forKey: .poiID)
        self.createdAt = try values.decode(String.self, forKey: .createdAt)
        self.updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        if let datas = try? values.decodeIfPresent(TRPYelpInfoModel.self, forKey: .value) {
            yelpModel = datas
        }
    }
    
}

struct TRPYelpInfoModel: Codable {
    let confirmURL: String
    let reservationID: String
    let restaurantImage: String
    let restaurantName: String
    let reservationStatus: TRPYelpReservationStatusInfoModel

    enum CodingKeys: String, CodingKey {
        case confirmURL = "confirmUrl"
        case reservationID = "reservation_id"
        case restaurantImage = "restaurant_image"
        case restaurantName = "restaurant_name"
        case reservationStatus = "reservation_status"
    }
}

// MARK: - ReservationStatus
struct TRPYelpReservationStatusInfoModel: Codable {
    let active: Bool
    let covers: Int
    let date, time: String
}
