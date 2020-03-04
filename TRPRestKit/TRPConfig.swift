//
//  TRPConfig.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 9.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal struct TRPConfig {

    internal static func getBaseUrl() -> String {
        return TRPClient.shared.baseUrl.baseUrl
    }
    
    internal static func getBaseUrlPath() -> String {
        return TRPClient.shared.baseUrl.basePath
    }
    
    internal static func getApiLink() -> String {
        return "https://\(TRPConfig.getBaseUrl())/\(TRPConfig.getBaseUrlPath())/"
    }
    
    internal enum ApiCall: String {
        case city
        
        case poiCategory
        case poi
        case questions
        case recommendations
        case routes
        case routesResult
        case gRouteReuslt
        case planPointAlternative
        case tags
        case checkDataUpdates
        case refresh
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
            case .city:
                return getNewLink() ?? "city"
            case .poiCategory:
                return getNewLink() ?? "poi-category"
            case .poi:
                return getNewLink() ?? "poi"
            case .questions:
                return getNewLink() ?? "question"
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
                return getNewLink() ?? "user-trip"
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
                return getNewLink() ?? "user-favorite"
            case .companion:
                return getNewLink() ?? "user-companion"
            case .refresh:
                return getNewLink() ?? "refresh"
            }
        }
        
        private func getNewLink() -> String? {
            return nil
        }
    }
    
}
