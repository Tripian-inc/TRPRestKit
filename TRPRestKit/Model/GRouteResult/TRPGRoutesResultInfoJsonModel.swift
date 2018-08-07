//
//  TRPGRoutesResultInfoJsonModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 21.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit
public struct TRPGRoutesResultInfoJsonModel: Decodable{
    
    public var travelMode: String?;
    public var htmlInstructions: String?;
    public var distance: TRPGRoutesResultTextValueJsonModel?;
    public var duration: TRPGRoutesResultTextValueJsonModel?;
    public var startLocation: TRPLocation?;
    public var endLocation: TRPLocation?;
    public var googlePoints: String?;
    
    enum CodingKeys: String, CodingKey {
        case travelMode = "travel_mode";
        case htmlInstructions = "html_instructions";
        case distance
        case duration
        case startLocation = "start_location";
        case endLocation = "end_location";
        case polyline
    }
    
    enum LocationCodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lng"
    }
    
    enum PolylineCodingKeys: String, CodingKey{
        case points
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        travelMode = try values.decodeIfPresent(String.self, forKey: .travelMode);
        htmlInstructions = try values.decodeIfPresent(String.self, forKey: .htmlInstructions);
        distance = try values.decodeIfPresent(TRPGRoutesResultTextValueJsonModel.self, forKey: .distance);
        duration = try values.decodeIfPresent(TRPGRoutesResultTextValueJsonModel.self, forKey: .duration);
        
        let startLocationContainer = try values.nestedContainer(keyedBy: LocationCodingKeys.self, forKey: .startLocation)
        if let sLat = try? startLocationContainer.decode(Float.self, forKey: .lat), let sLon = try? startLocationContainer.decode(Float.self, forKey: .lon) {
            startLocation = TRPLocation(lat: Double(sLat), lon: Double(sLon));
        }
        
        let endLocationContainer = try values.nestedContainer(keyedBy: LocationCodingKeys.self, forKey: .startLocation)
        if let eLat = try? endLocationContainer.decode(Float.self, forKey: .lat), let eLon = try? startLocationContainer.decode(Float.self, forKey: .lon) {
            endLocation = TRPLocation(lat: Double(eLat), lon: Double(eLon));
        }
        
        let polyline = try values.nestedContainer(keyedBy: PolylineCodingKeys.self, forKey: .polyline)
        googlePoints = try polyline.decodeIfPresent(String.self, forKey: .points)
    }
    
}
