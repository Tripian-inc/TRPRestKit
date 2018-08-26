//
//  TRPMyPrograms.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public class TRPMyProgram: TRPRestServices {
    
    var oaut:String?
    
    internal init(oaut: String, limit:Int? = 20) {
        self.oaut = oaut
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
            let result = try jsonDecode.decode(TRPMyProgramsJsonModel.self, from: data)
            self.Completion?(result, nil, nil);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func userOAuth() -> Bool {
        return true
    }
    
    public override func path() -> String {
        return TRPConfig.ApiCall.myPrograms.link;
    }
    
    public override func oauth() -> String? {
        return oaut
    }
}
