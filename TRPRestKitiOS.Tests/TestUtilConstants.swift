//
//  TestUtils.swift
//  TRPRestKitiOS.Tests
//
//  Created by Rozeri Dağtekin on 10/28/19.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//
/// # TestUtilConstants global mock constants that are used by Rest - Kit.
import TRPFoundationKit

struct TestUtilConstants {
    
    
    
    struct MockUserConstants {
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
        static let PlaceId =  516733 //David M. Arslantas istanbul
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
