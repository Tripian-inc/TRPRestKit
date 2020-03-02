//
//  TRPCompanionServices.swift
//  TRPRestKit
//
//  Created by Rozeri Dağtekin on 6/26/19.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit
public enum CompanionServiceType {
    case get, add, update, delete
}

//TODO: - TRPCompanionsJsonModel - TRPParentJsonModel OLARAK GÜNCELLENECEK
internal class TRPCompanionServices: TRPRestServices<TRPCompanionsJsonModel> {
    let serviceType: CompanionServiceType
    var id: Int?
    var name: String?
    var answers: [Int]?
    var age: Int?
    
    //service constructor to - add - companion.
    public init(serviceType: CompanionServiceType,
                name: String? = nil,
                answers: [Int]? = nil,
                age: Int? = nil) {
        self.serviceType = serviceType
        self.name = name
        self.answers = answers
        self.age = age
    }
    
    //service constructor to - update - user's companions.
    public init(serviceType: CompanionServiceType,
                id: Int, name: String? = nil,
                answers: [Int]? = nil,
                age: Int? = nil) {
        self.serviceType = serviceType
        self.id = id
        self.name = name
        self.answers = answers
        self.age = age
    }
    
    //service constructor to - delete - user's companion.
    public init(id: Int, serviceType: CompanionServiceType) {
        self.serviceType = serviceType
        self.id = id
    }
    
    //service constructor to - get - user's companions.
    public init(serviceType: CompanionServiceType) {
        self.serviceType = serviceType
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
            if serviceType == .get {
                let result = try jsonDecode.decode(TRPCompanionsJsonModel.self, from: data)
                self.completion?(result, nil, nil)
            } else if serviceType == .delete || serviceType == .update {
                let result = try jsonDecode.decode(TRPParentJsonModel.self, from: data)
                self.completion?(result, nil, nil)
            } else {
                let result = try jsonDecode.decode(TRPCompanionsJsonModel.self, from: data)
                self.completion?(result, nil, nil)
            }
        } catch let tryError {
            self.completion?(nil, tryError as NSError, nil)
        }
    }
    
    public override func parameters() -> [String: Any]? {
        var params: [String: Any] = [:]
        if let answers = answers {
            if answers.count > 0 {
                params["answers"] = answers.toString()
            }
        }
        if let name = name {
            params["name"] = name
        }
        if serviceType == .add {
            if let age = age {
                params["age"] = Int(age) // Add a companion da age int olacak.
            }
        } else {
            params["age"] = age
        }
        if serviceType == .get || serviceType == .delete {
            params["id"] = id
        }
        return params
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func path() -> String {
        if serviceType == .delete || serviceType == .update, let id = id {
            return TRPConfig.ApiCall.companion.link + "/\(id)"
        }
        return TRPConfig.ApiCall.companion.link
    }
    
    public override func requestMode() -> TRPRequestMode {
        if serviceType == .add {
            return TRPRequestMode.post
        } else if serviceType == .update {
            return TRPRequestMode.put
        } else if serviceType == .delete {
            return TRPRequestMode.delete
        }
        return TRPRequestMode.get
    }
}
