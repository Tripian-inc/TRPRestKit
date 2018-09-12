//
//  TRPQuestion.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 8.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPTripQuestion: TRPRestServices{
    
    private var cityId: Int?;
    private var questionId: Int?
    
    internal init(cityId: Int){
        self.cityId = cityId;
    }
    
    internal init(questionId: Int){
        self.questionId = questionId;
    }
    
    
    public override func servicesResult(data: Data?, error: NSError?) {
        if let error = error {
            self.Completion?(nil,error, nil);
            return
        }
        guard let data = data else {
            self.Completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        let jsonDecode = JSONDecoder();
        do {
            let result = try jsonDecode.decode(TRPTripQuestionJsonModel.self, from: data)
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        var link = TRPConfig.ApiCall.Questions.link
        if let questionId = questionId {
            link += "/\(questionId)"
        }
        return link
    }
    
    public override func parameters() -> Dictionary<String, Any>? {
        if let cityId = cityId {
            return ["city_id":"\(cityId)"];
        }
        return nil
    }
    
}
