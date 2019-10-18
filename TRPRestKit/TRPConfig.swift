//
//  TRPConfig.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 9.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal struct TRPConfig {
    
    internal static var BaseUrl: String = "0swjhnxnqd.execute-api.ca-central-1.amazonaws.com"
        
    //buda tanımlanıcak. Versiyon
    internal static var BaseUrlPath: String = "v2"

    //public static let BaseUrl: String = "ybesi12ydk.execute-api.us-east-1.amazonaws.com"
    //public static let BaseUrlPath: String = "v02"
    
    internal static func apiLink() -> String {
        return "https://\(BaseUrl)/\(BaseUrlPath)/"
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
