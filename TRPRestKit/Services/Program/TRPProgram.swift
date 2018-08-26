//
//  TRPProgram.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.08.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPProgram: TRPRestServices{
    
    var cityId:Int?;
    
    internal override init() {}
    
    internal init(cityId:Int) {
        self.cityId = cityId;
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
            self.paginationController(parentJson: result) { (pagination) in
                self.Completion?(result, nil, pagination);
            }
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.Cities.link;
        if let id = cityId {
            path += "/\(id)"
        }
        return path;
    }
    
}
