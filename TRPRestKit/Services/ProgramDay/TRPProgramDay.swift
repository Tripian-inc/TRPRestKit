//
//  TRPProgramDay.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 28.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPProgramDay: TRPRestServices {
    
    var position:TRPProgramDayPosition?
    var hash: String?
    
    internal init(hash: String, position: TRPProgramDayPosition) {
        self.hash = hash
        self.position = position
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
            let result = try jsonDecode.decode(TRPProgramDayJsonModel.self, from: data)
            self.Completion?(result, nil, nil);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.ProgramDay.link;
    }
    
    override func requestMode() -> TRPRequestMode {
        return TRPRequestMode.post
    }
    
    override func parameters() -> Dictionary<String, Any>? {
        var params : Dictionary<String, Any> = [:];
        if let position = position {
            params["position"] = position.getParams()
        }
        
        if let hash = hash {
            params["hash"] = hash
        }
        
        return params
    }
}


public enum TRPProgramDayPosition{
    case beginning, end
    
    func getParams() -> String{
        switch self {
        case .beginning:
            return "beginning"
        case .end:
            return "end"
        }
    }
}
