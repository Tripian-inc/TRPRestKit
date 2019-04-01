//
//  TRPReportAProblemServices.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.03.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPReportAProblemServices: TRPRestServices {
    
    let categoryId: Int
    var message: String?
    var poiId: Int?
    
    internal init(categoryId id: Int,
                           message msg: String? = nil,
                           poiId poi: Int? = nil) {
        self.categoryId = id
        self.message = msg
        self.poiId = poi
    }
    
    override func servicesResult(data: Data?, error: NSError?) {
        
        if let error = error {
            self.Completion?(nil,error, nil)
            return
        }
        
        guard let data = data else {
            self.Completion?(nil, TRPErrors.wrongData as NSError, nil)
            return
        }
        
        let jsonDecode = JSONDecoder()
        do {
            let result = try jsonDecode.decode(TRPReportAProblemJsonModel.self, from: data)
            self.Completion?(result,nil,nil)
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
        
    }
    
    override func path() -> String {
        return "reportaproblem"
    }
    
    override func parameters() -> Dictionary<String, Any>? {
        var params : Dictionary<String, Any> = [:]
        params["problem_category"] = categoryId
        
        if let message = message {
            params["message"] = message
        }
        if let poiId = poiId {
            params["poi_id"] = poiId
        }
        return params
    }
    
    override func requestMode() -> TRPRequestMode {
        return .post
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
}

internal class TRPReportAProblemJsonModel:  TRPParentJsonModel {
    
    public var data: TRPReportAProblemInfoModel?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(TRPReportAProblemInfoModel.self
            , forKey: .data)
        try super.init(from: decoder)
    }
    
}

public struct TRPReportAProblemInfoModel: Decodable {
    
    let id: Int
    let problemCategory: String?
    let message: String?
    var poiId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case problemCategory = "problem_category"
        case message
        case poiId = "poi_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.problemCategory = try values.decodeIfPresent(String.self, forKey: .problemCategory)
        self.message = try values.decodeIfPresent(String.self, forKey: .message)
        self.poiId = try values.decodeIfPresent(Int.self, forKey: .poiId)
    }
    
}
