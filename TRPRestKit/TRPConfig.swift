//
//  TRPConfig.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 9.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPConfig {
    public static let BaseUrl: String = "34.251.216.241"
    public static let BaseUrlPath: String = "tripian-tools/public/api"
    
    public static var apiLink: String {
        return "http://\(BaseUrl)/\(BaseUrlPath)/"
    }
    
    public enum ApiCall: String {
        case Cities
        case Types
        case Places
        case Questions
        case Recommendations
        case Routes
        case RoutesResult
        case GRouteReuslt
        case NearbyResult
        case Tags
        case CheckDataUpdates
        case User
        var link: String {
            switch self {
            case .Cities:
                return getNewLink() ?? "cities"
            case .Types:
                return getNewLink() ?? "type"
            case .Places:
                return getNewLink() ?? "places"
            case .Questions:
                return getNewLink() ?? "questions"
            case .Recommendations:
                return getNewLink() ?? "recommendation"
            case .Routes:
                return getNewLink() ?? "routes"
            case .RoutesResult:
                return getNewLink() ?? "routeresult"
            case .GRouteReuslt:
                return getNewLink() ?? "grouteresult"
            case .NearbyResult:
                return getNewLink() ?? "nearbyresult"
            case .Tags:
                return getNewLink() ?? "tags"
            case .CheckDataUpdates:
                return getNewLink() ?? "check-data-updates"
            case .User:
                return getNewLink() ?? "v1/auth"
            }
        }
        
        private func getNewLink() -> String? {
            return nil
        }
    }
    
}
