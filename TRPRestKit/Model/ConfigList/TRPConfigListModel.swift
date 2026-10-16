//
//  TRPConfigListModel.swift
//  TRPRestKit
//
//  Copyright © 2026 Tripian Inc. All rights reserved.
//

import Foundation

/// The platform configuration `misc/config-list` answers with, narrowed to what the app reads.
/// A missing or wrongly typed field decodes as nil and unknown keys are ignored.
/// `mapboxAccessToken` and `googlePlacesApiKey` are the map and places credentials of the customer the api key belongs to.
public struct TRPConfigListModel: Codable {
    public let apiKey: String?
    public let providers: TRPConfigProvidersModel?
    public let mapboxAccessToken: String?
    public let googlePlacesApiKey: String?

    private enum CodingKeys: String, CodingKey {
        case apiKey, providers, mapboxAccessToken, googlePlacesApiKey
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        apiKey = container.lenient(String.self, forKey: .apiKey)
        providers = container.lenient(TRPConfigProvidersModel.self, forKey: .providers)
        mapboxAccessToken = container.lenient(String.self, forKey: .mapboxAccessToken)
        googlePlacesApiKey = container.lenient(String.self, forKey: .googlePlacesApiKey)
    }
}

/// The third-party providers enabled for the platform, grouped by what they offer.
/// An element of a group that does not decode is skipped.
public struct TRPConfigProvidersModel: Codable {
    public let tourAndTicket: [TRPConfigProviderModel]?
    public let transportation: [TRPConfigProviderModel]?
    public let restaurant: [TRPConfigProviderModel]?
    public let accommodation: [TRPConfigProviderModel]?

    private enum CodingKeys: String, CodingKey {
        case tourAndTicket, transportation, restaurant, accommodation
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tourAndTicket = container.lenientElements(TRPConfigProviderModel.self, forKey: .tourAndTicket)
        transportation = container.lenientElements(TRPConfigProviderModel.self, forKey: .transportation)
        restaurant = container.lenientElements(TRPConfigProviderModel.self, forKey: .restaurant)
        accommodation = container.lenientElements(TRPConfigProviderModel.self, forKey: .accommodation)
    }
}

/// One provider and the credentials the platform uses with it. `name` is kept as the backend sends it.
public struct TRPConfigProviderModel: Codable {
    public let id: Int?
    public let name: String?
    public let apiKey: String?
    public let apiUrl: String?
    public let clientId: String?
    public let limit: Int?
    public let prod: Bool?

    private enum CodingKeys: String, CodingKey {
        case id, name, apiKey, apiUrl, clientId, limit, prod
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = container.lenient(Int.self, forKey: .id)
        name = container.lenient(String.self, forKey: .name)
        apiKey = container.lenient(String.self, forKey: .apiKey)
        apiUrl = container.lenient(String.self, forKey: .apiUrl)
        clientId = container.lenient(String.self, forKey: .clientId)
        limit = container.lenient(Int.self, forKey: .limit)
        prod = container.lenient(Bool.self, forKey: .prod)
    }
}

private extension KeyedDecodingContainer {

    /// Nil when the key is missing, null or holds a value of another type.
    func lenient<T: Decodable>(_ type: T.Type, forKey key: Key) -> T? {
        return (try? decodeIfPresent(type, forKey: key)) ?? nil
    }

    /// The elements of the array under `key` that decode, or nil when the key is missing, null or not an array.
    func lenientElements<T: Decodable>(_ type: T.Type, forKey key: Key) -> [T]? {
        guard (try? decodeNil(forKey: key)) == false,
              var array = try? nestedUnkeyedContainer(forKey: key) else {
            return nil
        }
        var elements: [T] = []
        while !array.isAtEnd {
            let index = array.currentIndex
            if let element = try? array.decode(type) {
                elements.append(element)
            } else {
                _ = try? array.decode(SkippedElement.self)
            }
            if array.currentIndex == index {
                break
            }
        }
        return elements
    }
}

/// Consumes one array element of any shape.
private struct SkippedElement: Decodable {

    init(from decoder: Decoder) throws {}
}
