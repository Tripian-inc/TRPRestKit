//
//  TestUtils.swift
//  TRPRestKitiOS.Tests
//
//  Created by Rozeri Dağtekin on 10/28/19.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//
/// # TestUtilConstants global mock constants that are used by Rest - Kit.
import TRPFoundationKit
import TRPRestKit
struct TestUtilConstants {
    
    //AStartTestSettingsTest den ayarlanır.
    static var targetServer: Server = .airMiles
    
    enum Server {
        case test, sandBox, product, airMiles
        var apiKey: String {
            switch self {
            case .test:
                return ApiKeys.Test
            case .sandBox:
                return ApiKeys.Product
            case .product:
                return ApiKeys.Product
            case .airMiles:
                return ApiKeys.AirMiles
            }
        }
        
        var url: BaseUrlCreater {
            switch self {
            case .test:
                return Environment.test.baseUrl
            case .product:
                return Environment.production.baseUrl
            case .sandBox:
                return Environment.sandbox.baseUrl
            case .airMiles:
                return BaseUrlCreater(baseUrl: "0swjhnxnqd.execute-api.ca-central-1.amazonaws.com", basePath: "v2")
            }
        }
    }

    struct ApiKeys {
        static let Test = "Y6owtuGXyq7L8IeCenyZQ4gWIX3KSkeZ6KiMPamF"
        static let SandBox = "p3AhT0190A2OAvFPKN98b9gfkbNh12HH6nofhKfM"
        static let Product = "u18Yn5ckY5JvkLGptnNA1mLit19SmwS1O1f9UGGc"
        static let AirMiles = "oDlzmHfvrjaMUpJbIP7y55RuONbYGaNZ6iW4PMAn"
    }
    struct MockUserConstants {
        static let TestUserName = "mobile-test"
        static let Email = "r@g.com"
        static let Password =  "111111"
    }
    
    struct MockCityConstants {
        static let IstanbulCityId = 107
        static let IstanbulCityName = "Istanbul"
        static let Istanbullocation = TRPLocation(lat: 41, lon: 29)
    }
    
    struct MockPoiCategoryConstants {
        static let PoiCategoryId =  26
        static let PoiCategoryType =  3
        static let CategoryIds = [1, 4]
    }
    
    struct MockPlaceConstants {
        static let PlaceId =  "516733" //David M. Arslantas istanbul
    }
    
    struct MockQuestionConstants {
        static let QuestionId =  1
    }
    
    struct MockReportProblem {
        static let ProblemCategoryId =  "4"
        static let ProblemText =  ""
    }
    
    struct MockTimeConstants {
        static let SecondsLong: Double =  12.0
        static let SecondsMedium: Double =  12.0
        static let SecondsShort: Double =  12.0
    }
}
