//
//  TRPMe.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
//TODO - TOKEN I Bİ YERE KAYDET VE ORADAN KULLAN
internal class TRPUserInfoServices: TRPRestServices {
    
    enum ServiceType {
        case getInfo, updateInfo, updateAnswer
    }
    
    let serviceType: ServiceType
    var password: String?
    var answers: [Int]?
    var firstName: String?
    var lastName: String?
    var age: Int?
    
    init(type: ServiceType) {
        self.serviceType = type
    }
    
    init(answers: [Int]) {
        self.serviceType = .updateAnswer
        self.answers = answers
    }
    
    init(firstName: String? = nil, lastName:String? = nil, age:Int? = nil, password: String? = nil, answers: [Int]? = nil) {
        self.serviceType = .updateInfo
        self.password = password
        self.answers = answers
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
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
            let result = try jsonDecode.decode(TRPUserInfoJsonModel.self, from: data)
            self.Completion?(result, nil, nil);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func parameters() -> Dictionary<String, Any>? {
        var params: Dictionary<String, Any> = [:]
        if serviceType == .updateAnswer {
            if let answers = answers {
                params["answers"] = answers.toString()
            }
        }else if serviceType == .updateInfo {
            if let password = password {
                params["password"] = password
            }
            if let answers = answers {
                if answers.toString().count > 0{
                    params["answers"] = answers.toString()
                }
            }
            if let firstName = firstName {
                params["first_name"] = firstName
            }
            if let lastName = lastName {
                params["last_name"] = lastName
            }
            if let age = age {
                params["age"] = "\(age)"
            }
        }
        return params
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.user.link;
    }
    
    public override func requestMode() -> TRPRequestMode {
        if serviceType == .updateAnswer || serviceType == .updateInfo{
            return TRPRequestMode.put
        }
        return TRPRequestMode.get
    }
}
