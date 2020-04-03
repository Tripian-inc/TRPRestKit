//
//  TRPConfig.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 9.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

internal struct TRPConfig: ApiConfigurationConstant {
    
    var envirement: Environment {
        return TRPClient.shared.enviroment
    }
    
    var baseUrl: BaseUrlCreater {
        switch envirement {
        case .test:
            return BaseUrlCreater(baseUrl: "6ezq4jb2mk.execute-api.eu-west-1.amazonaws.com", basePath: "api")
        case .sandbox:
            return BaseUrlCreater(baseUrl: "uqo7xnd7f9.execute-api.eu-west-1.amazonaws.com", basePath: "v2")
        case .production:
            return BaseUrlCreater(baseUrl: "ybesi12ydk.execute-api.us-east-1.amazonaws.com", basePath: "v02")
        }
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
        case stepAlternative
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
        case step
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
            case .stepAlternative:
                return getNewLink() ?? "step-alternative"
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
                return getNewLink() ?? "plan"
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
            case .step:
                return getNewLink() ?? "step"
            }
        }
        
        private func getNewLink() -> String? {
            return nil
        }
    }
    
}