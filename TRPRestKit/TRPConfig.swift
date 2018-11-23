//
//  TRPConfig.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 9.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public struct TRPConfig {
    public static let BaseUrl: String = "ybesi12ydk.execute-api.us-east-1.amazonaws.com"
    public static let BaseUrlPath: String = "v02"
    
    public static var apiLink: String {
        return "http://\(BaseUrl)/\(BaseUrlPath)/"
    }
    
    public enum ApiCall: String {
        case Cities
        case GetcityByCoordinates
        case PoiCategories
        case Poi
        case Questions
        case Recommendations
        case Routes
        case RoutesResult
        case GRouteReuslt
        case PlanPointAlternative
        case Tags
        case CheckDataUpdates
        case User
        case Login
        case user
        case UserTrips
        case Trip
        case DayPlan
        case UserPreferences
        case DailyPlanPoi
        case Register
        case Favorite
        var link: String {
            switch self {
            case .Cities:
                return getNewLink() ?? "cities"
            case .GetcityByCoordinates:
                return getNewLink() ?? "getcitybycoordinate"
            case .PoiCategories:
                return getNewLink() ?? "poi-categories"
            case .Poi:
                return getNewLink() ?? "poi"
            case .Questions:
                return getNewLink() ?? "trip-questions"
            case .Recommendations:
                return getNewLink() ?? "recommendation"
            case .Routes:
                return getNewLink() ?? "routes"
            case .RoutesResult:
                return getNewLink() ?? "routeresult"
            case .GRouteReuslt:
                return getNewLink() ?? "grouteresult"
            case .PlanPointAlternative:
                return getNewLink() ?? "dailyplanpoi-alternatives"
            case .Tags:
                return getNewLink() ?? "tags"
            case .CheckDataUpdates:
                return getNewLink() ?? "check-data-updates"
            case .User:
                return getNewLink() ?? "user"
            case .Login:
                return getNewLink() ?? "login"
            case .user:
                return getNewLink() ?? "user"
            case .UserTrips:
                return getNewLink() ?? "user/trips"
            case .Trip:
                return getNewLink() ?? "trip"
            case .DayPlan:
                return getNewLink() ?? "dayplan"
            case .UserPreferences:
                return getNewLink() ?? "user/preferences"
            case .DailyPlanPoi:
                return getNewLink() ?? "dailyplanpoi"
            case .Register:
                return getNewLink() ?? "register"
            case .Favorite:
                return getNewLink() ?? "user/favorites"
            }
        }
        
        private func getNewLink() -> String? {
            return nil
        }
    }
    
}
