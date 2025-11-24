//
//  TRPTimelineStepCustomPoiModel.swift
//  TRPRestKit
//
//  Created by Cem Çaygöz on 20.08.2025.
//  Copyright © 2025 Evren Yaşar. All rights reserved.
//

import TRPFoundationKit

/// A model representing a custom Point of Interest (POI) that can be used in timeline steps.
/// This allows users to create timeline steps for locations that are not available in the
/// Tripian POI database, providing full flexibility for custom travel itineraries.
public struct TRPTimelineStepCustomPoiModel: Codable {
    /// The display name of the custom Point of Interest.
    var name: String?
    
    /// The geographical coordinates (latitude and longitude) of the custom POI.
    /// This is used for mapping and navigation purposes.
    var coordinate: TRPLocation?
    
    /// The physical address or location description of the custom POI.
    var address: String?
    
    /// A detailed description of the custom POI, explaining what it is or why it's significant.
    var description: String?
    
    /// An array of tags or categories that help classify the custom POI (e.g., ["restaurant", "italian"]).
    var tags: [String]?
    
    /// The contact phone number for the custom POI, if applicable.
    var phone: String?
    
    /// The website URL for the custom POI, if available.
    var web: String?
    
    /// The category identifier that classifies the type of POI (e.g., restaurant, attraction, hotel).
    var categoryId: Int?
    
    public init(name: String? = nil, coordinate: TRPLocation? = nil, address: String? = nil, description: String? = nil, tags: [String]? = nil, phone: String? = nil, web: String? = nil, categoryId: Int? = nil) {
        self.name = name
        self.coordinate = coordinate
        self.address = address
        self.description = description
        self.tags = tags
        self.phone = phone
        self.web = web
        self.categoryId = categoryId
    }
}

extension TRPTimelineStepCustomPoiModel {
    func getBodyParameters() -> [String: Any] {
        var parameters: [String: Any] = [:]
        if let name = name {
            parameters["name"] = name
        }
        if let coordinate = coordinate {
            parameters["coordinate"] = coordinate.json()
        }
        if let address = address {
            parameters["address"] = address
        }
        if let description = description {
            parameters["description"] = description
        }
        if let tags = tags {
            parameters["tags"] = tags
        }
        if let phone = phone {
            parameters["phone"] = phone
        }
        if let web = web {
            parameters["web"] = web
        }
        if let categoryId = categoryId {
            parameters["categoryId"] = categoryId
        }
        return parameters
    }
}
