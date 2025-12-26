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
        case shorexCities
        
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
        case timeline
        case dailyPlan
        case userPreferences
        case dailyPlanPoi
        case register
        case guestLogin
        case lightLogin
        case favorite
        case step
        case companion
        case userReaction
        case userReservation
        case socialLogin
        case logout
        case resetPassword
        case notifications
        case offers
        case optInOffers
        case exportItinerary
        case timelineStep
        case tourSearch
        var link: String {
            switch self {
            case .city:
                return "cities"
            case .poiCategory:
                return "poi-categories"
            case .poi:
                return "pois"
            case .questions:
                return "trip/questions"
            case .recommendations:
                return "recommendations"
            case .routes:
                return "routes"
            case .routesResult:
                return "routeresult"
            case .gRouteReuslt:
                return "grouteresult"
            case .stepAlternative:
                return "step/alternatives"
            case .tags:
                return "tags"
            case .checkDataUpdates:
                return "check-data-updates"
            case .login:
                return "auth/login"
            case .user:
                return "user"
            case .userTrips:
                return "trips"
            case .trip:
                return "trips"
            case .dailyPlan:
                return "plans"
            case .userPreferences:
                return "user/preferences"
            case .dailyPlanPoi:
                return "dailyplanpoi"
            case .register:
                return "auth/register"
            case .favorite:
                return "favorites"
            case .companion:
                return "companions"
            case .refresh:
                return "auth/refresh-token"
            case .step:
                return "steps"
            case .userReaction:
                return "reactions"
            case .userReservation:
                return "bookings"
            case .socialLogin:
                return "auth/login-social"
            case .logout:
                return "auth/logout"
            case .resetPassword:
                return "auth/reset-password"
            case .notifications:
                return "notifications"
            case .offers:
                return "offers"
            case .optInOffers:
                return "offers/opt-in"
            case .exportItinerary:
                return "misc/export-itinerary"
            case .shorexCities:
                return "shorex-cities"
            case .guestLogin:
                return "auth/guest-login"
            case .lightLogin:
                return "auth/light-register-login"
            case .timeline:
                return "timeline"
            case .timelineStep:
                return "timeline/steps"
            case .tourSearch:
                return "tour-api/search"
            }
        }
    }

}
