//
//  TRPConfig.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 9.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal struct TRPConfig {
    
    //TestServer return "v2jvnaq3nl.execute-api.eu-west-1.amazonaws.com"
    //return "ybesi12ydk.execute-api.us-east-1.amazonaws.com"
    //us-west geliştirme sandbox
    //return "v2jvnaq3nl.execute-api.eu-west-1.amazonaws.com" //TestServer
    //Airmiles - ca-cemtral
    
    internal static func getBaseUrl() -> String {
        return "0swjhnxnqd.execute-api.ca-central-1.amazonaws.com"
    }
    
    internal static func getBaseUrlPath() -> String {
        return "v2"
    }
    
    internal static func getApiLink() -> String {
        return "https://\(TRPConfig.getBaseUrl())/\(TRPConfig.getBaseUrlPath())/"
    }
    
    internal enum ApiCall: String {
        case cities
        case getcityByCoordinates
        case poiCategories
        case poi
        case questions
        case recommendations
        case routes
        case routesResult
        case gRouteReuslt
        case planPointAlternative
        case tags
        case checkDataUpdates
        
        case login
        case user
        case userTrips
        case trip
        case dailyPlan
        case userPreferences
        case dailyPlanPoi
        case register
        case favorite
        case companion
        var link: String {
            switch self {
            case .cities:
                return getNewLink() ?? "cities"
            case .getcityByCoordinates:
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
            case .gRouteReuslt:
                return getNewLink() ?? "grouteresult"
            case .planPointAlternative:
                return getNewLink() ?? "dailyplanpoi-alternatives"
            case .tags:
                return getNewLink() ?? "tags"
            case .checkDataUpdates:
                return getNewLink() ?? "check-data-updates"
            case .login:
                return getNewLink() ?? "login"
            case .user:
                return getNewLink() ?? "user"
            case .userTrips:
                return getNewLink() ?? "user/trips"
            case .trip:
                return getNewLink() ?? "trip"
            case .dailyPlan:
                return getNewLink() ?? "dailyplan"
            case .userPreferences:
                return getNewLink() ?? "user/preferences"
            case .dailyPlanPoi:
                return getNewLink() ?? "dailyplanpoi"
            case .register:
                return getNewLink() ?? "register"
            case .favorite:
                return getNewLink() ?? "user/favorites"
            case .companion:
                return getNewLink() ?? "user/companion"
            }
        }
        
        private func getNewLink() -> String? {
            return nil
        }
    }
    
}
