//
//  TRPConfig.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 9.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal struct TRPConfig {
    
    internal static var BaseUrl: String {
        get {
            //TestServer return "v2jvnaq3nl.execute-api.eu-west-1.amazonaws.com"
            //return "ybesi12ydk.execute-api.us-east-1.amazonaws.com"
            //us-west geliştirme sandbox
            //return "v2jvnaq3nl.execute-api.eu-west-1.amazonaws.com" //TestServer
            //Airmiles - ca-cemtral
            return "0swjhnxnqd.execute-api.ca-central-1.amazonaws.com" // AirMiles
        }
    }
    //buda tanımlanıcak. Versiyon
    internal static var BaseUrlPath: String {
        get {
            return "v2"
        }
    }
    
    //public static let BaseUrl: String = "ybesi12ydk.execute-api.us-east-1.amazonaws.com"
    //public static let BaseUrlPath: String = "v02"
    
    internal static var apiLink: String {
        get {
            return "https://\(BaseUrl)/\(BaseUrlPath)/"
        }
    }
    
    internal enum ApiCall: String {
        case cities
        case getCityByCoordinates
        case poiCategories
        case poi
        case questions
        case recommendations
        case routes
        case routesResult
        case googleRouteReuslt
        case planPointAlternative
        case tags
        case checkDataUpdates
        case user
        case login
        case userTrips
        case Trip
        case DailyPlan
        case UserPreferences
        case DailyPlanPoi
        case Register
        case Favorite
        case Companion
        
        var link: String {
            switch self {
            case .cities:
                return getNewLink() ?? "cities"
            case .getCityByCoordinates:
                return getNewLink() ?? "getcitybycoordinate"
            case .poiCategories:
                return getNewLink() ?? "poi-categories"
            case .poi:
                return getNewLink() ?? "poi"
            case .questions:
                return getNewLink() ?? "trip-questions"
            case .recommendations:
                return getNewLink() ?? "recommendation"
            case .routes:
                return getNewLink() ?? "routes"
            case .routesResult:
                return getNewLink() ?? "routeresult"
            case .googleRouteReuslt:
                return getNewLink() ?? "grouteresult"
            case .planPointAlternative:
                return getNewLink() ?? "dailyplanpoi-alternatives"
            case .tags:
                return getNewLink() ?? "tags"
            case .checkDataUpdates:
                return getNewLink() ?? "check-data-updates"
            case .user:
                return getNewLink() ?? "user"
            case .login:
                return getNewLink() ?? "login"
            case .user:
                return getNewLink() ?? "user"
            case .userTrips:
                return getNewLink() ?? "user/trips"
            case .Trip:
                return getNewLink() ?? "trip"
            case .DailyPlan:
                return getNewLink() ?? "dailyplan"
            case .UserPreferences:
                return getNewLink() ?? "user/preferences"
            case .DailyPlanPoi:
                return getNewLink() ?? "dailyplanpoi"
            case .Register:
                return getNewLink() ?? "register"
            case .Favorite:
                return getNewLink() ?? "user/favorites"
            case .Companion:
                return getNewLink() ?? "user/companion"
            }
        }
        
        private func getNewLink() -> String? {
            return nil
        }
    }
    
}
