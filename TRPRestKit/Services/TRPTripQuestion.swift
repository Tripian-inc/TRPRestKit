//
//  TRPQuestion.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 8.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

/// Indicates question type
///
/// - trip: question about Trip.
/// - profile: question about user profile.
public enum TRPQuestionCategory: String {
    // Question about Trip.
    case trip
    // Question about user profile.
    case profile
    //Question about companion.
    case companion 
}

internal class TRPQuestionService: TRPRestServices {
    
    private var cityId: Int?
    public var tripType = TRPQuestionCategory.trip
    public var language: String?
    
    internal init(cityId: Int) {
        self.cityId = cityId
    }
    
    internal init(tripType: TRPQuestionCategory) {
        self.tripType = tripType
    }
    
    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.completion?(nil, error, nil)
            return
        }
        guard let data = data else {
            self.completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        let jsonDecode = JSONDecoder()
        do {
            let result = try jsonDecode.decode(TRPQuestionJsonModel.self, from: data)
            let pag = paginationController(parentJson: result)
            self.completion?(result, nil, pag)
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.questions.link
    }
    
    public override func parameters() -> [String: Any]? {
        var dic: [String: Any] = [:]
        if let cityId = cityId {
            dic["city_id"] = "\(cityId)"
            dic["category"] = "\(tripType.rawValue)"
            if let lang = language {
                dic["language_code"] = "\(lang)"
            }
            
            return dic
        }
        dic["category"] = "\(tripType.rawValue)"
        return dic
    }
    
}
