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
public enum TPRTripQuestionType: String {
    // Question about Trip.
    case trip = "trip"
    // Question about user profile.
    case profile = "profile"
    //Question about companion.
    case companion = "companion"
}

internal class TRPTripQuestion: TRPRestServices{
    
    private var cityId: Int?;
    private var questionId: Int?
    public var tripType = TPRTripQuestionType.trip
    public var language: String?;
    
    
    internal init(cityId: Int){
        self.cityId = cityId;
    }
    
    internal init(questionId: Int){
        self.questionId = questionId;
    }
    
    internal init(tripType: TPRTripQuestionType){
        self.tripType = tripType;
    }
    
    
    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.completion?(nil,error, nil);
            return
        }
        guard let data = data else {
            self.completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        let jsonDecode = JSONDecoder();
        do {
            let result = try jsonDecode.decode(TRPTripQuestionJsonModel.self, from: data)
            let pag = paginationController(parentJson: result)
            self.completion?(result, nil, pag);
        }catch(let tryError) {
            self.completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        var link = TRPConfig.ApiCall.questions.link
        if let questionId = questionId {
            link += "/\(questionId)"
        }
        return link
    }
    
    public override func parameters() -> Dictionary<String, Any>? {
        
        if let cityId = cityId {
            var dic: Dictionary<String, Any> = [:]
            dic["city_id"] = "\(cityId)"
            dic["category"] = "\(tripType.rawValue)"
            
            if let lang = language {
                dic["language_code"] = "\(lang)"
            }
            
            return dic
        }
        return nil
    }
    
}
