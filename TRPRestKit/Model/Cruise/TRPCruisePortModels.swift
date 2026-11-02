//
//  TRPCruisePortModels.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// The ports of one continent.
public struct TRPCruisePortGroupModel: Codable {
    public let continent: String
    public let ports: [TRPCruisePortItemModel]
}

/// A port, and the city it belongs to when it has one.
public struct TRPCruisePortItemModel: Codable {
    public let id: Int
    public let name: String
    public let cityId: Int?
    public let lat: Double?
    public let lng: Double?
}

/// A section of the practical information about a port or its city.
public struct TRPCruisePortInfoModel: Codable {
    public let id: Int
    public let title: String
    public let content: String
    public let icon: String?
    public let slug: String?
}
