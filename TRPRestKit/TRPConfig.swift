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
    public static let BaseUrlPath: String = "tripian-apiV2/public/v2"
    
    public static var apiLink: String {
        return "http://\(BaseUrl)/\(BaseUrlPath)/"
    }
    
    public enum ApiCall: String {
        case Cities
        case PlaceTypes
        case Places
        case Questions
        case Recommendations
        case Routes
        case RoutesResult
        case GRouteReuslt
        case Nearby
        case NearbyAll
        case Tags
        case CheckDataUpdates
        case User
        case Oauth
        case me
        case MyProgram
        case Program
        case ProgramDay
        case Preferences
        var link: String {
            switch self {
            case .Cities:
                return getNewLink() ?? "cities"
            case .PlaceTypes:
                return getNewLink() ?? "placetypes"
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
            case .Nearby:
                return getNewLink() ?? "nearby"
            case .NearbyAll:
                return getNewLink() ?? "nearbyall"
            case .Tags:
                return getNewLink() ?? "tags"
            case .CheckDataUpdates:
                return getNewLink() ?? "check-data-updates"
            case .User:
                return getNewLink() ?? "user"
            case .Oauth:
                return getNewLink() ?? "auth/token"
            case .me:
                return getNewLink() ?? "me"
            case .MyProgram:
                return getNewLink() ?? "myprograms"
            case .Program:
                return getNewLink() ?? "program"
            case .ProgramDay:
                return getNewLink() ?? "programday"
            case .Preferences:
                return getNewLink() ?? "preferences"
            }
        }
        
        private func getNewLink() -> String? {
            return nil
        }
    }
    
}
