//
//  TRPPreferences.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPUseerPreferences: TRPRestServices {
    
    var typeId: Int?;
    enum PreferenceStatus {
        case get
        case add
        case update
        case delete
    }
    var status: PreferenceStatus = .get
    var id:Int?
    var key: String?
    var value: String?
    
    internal override init() {
        status = .get
    }
    
    internal init(key:String, value: String, type: PreferenceStatus) {
        self.key = key
        self.value = value
        self.status = type
    }
    
    internal init(id:Int, key:String?, value:String?) {
        status = .update
        self.id = id
        self.key = key
        self.value = value
    }
    
    internal init(id:Int) {
        status = .delete
        self.id = id
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
            let result = try jsonDecode.decode(TRPPreferenceJsonModel.self, from: data)
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    override func requestMode() -> TRPRequestMode {
        switch status {
        case .get:
            return TRPRequestMode.get
        case .add:
            return TRPRequestMode.get
        case .update:
            return TRPRequestMode.put
        case .delete:
            return TRPRequestMode.delete
        }
    }
    
    override func parameters() -> Dictionary<String, Any>? {
        var params: Dictionary<String, Any> = [:]
        if status == .add {
            params["key"] = key ?? ""
            params["value"] = value ?? ""
        }else if status == .delete {
            params["id"] = id ?? 0
        }else if status == .update {
            params["id"] = id ?? 0
            params["key"] = key ?? ""
            params["value"] = value ?? ""
        }
        return params
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.UserPreferences.link;
    }
    
    override func userOAuth() -> Bool {
        return true
    }
}
