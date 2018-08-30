//
//  TRPProgramSteps.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
// TODO: - ORDER KALDIRILABİLİR
internal class TRPProgramSteps: TRPRestServices {
    
    enum Status {
        case add
        case get
        case update
        case delete
    }
    
    var type: Status = Status.get
    var programStepId: Int?
    var hash: String?
    var dayId: Int?
    var placeId: Int?
    var order: Int?
    
    
    /// Add new ProgramStep
    internal init(hash:String, dayId: Int, placeId:Int, order:Int) {
        type = Status.add
        self.hash = hash
        self.dayId = dayId
        self.placeId = placeId
        self.order = order
    }
    
    /// ProgramStep Get or Delete With Id
    internal init(id: Int, type: Status) {
        self.type = type
        self.programStepId = id
    }
    
    /// ProgramStep Update
    internal init(id:Int, dayId:Int?, placeId: Int?, order:Int?) {
        self.programStepId = id
        self.dayId = dayId
        self.placeId = placeId
        self.order = order
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
            let result = try jsonDecode.decode(TRPProgramStepJsonModel.self, from: data)
            self.Completion?(result, nil, nil);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.ProgramStep.link
        
        if type != .update {
            if let id = programStepId {
                path += "/\(id)"
            }
        }
        
        return path
    }
    
    override func requestMode() -> TRPRequestMode {
        if type == Status.add {
            return TRPRequestMode.post
        }else if type == Status.get {
            return TRPRequestMode.get
        }else if type == Status.update {
            return TRPRequestMode.put
        }else if type == Status.delete {
            return TRPRequestMode.delete
        }
        return TRPRequestMode.get
    }
    
    override func parameters() -> Dictionary<String, Any>? {
        var params : Dictionary<String, Any> = [:];
        if type == .add {
            if let dayId = dayId,
                let placeId = placeId,
                let hash = hash {
                params["hash"] = hash
                params["day_id"] = dayId
                params["place_id"] = placeId
                if let order = order {
                    params["order"] = order
                }
            }
        }else if type == .update {
            guard let id = programStepId else {
                return params
            }
            params["id"] = id
            if let dayId = dayId {
                params["day_id"] = dayId
            }
            if let placeId = placeId {
                params["place_id"] = placeId
            }
            if let order = order {
                params["order"] = order
            }
        }
        return params
    }
}
