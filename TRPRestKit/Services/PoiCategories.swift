//
//  TRPType.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 7.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
internal class PoiCategories: TRPRestServices {
    
    var typeId: Int?;
    
    internal override init() {}
    
    internal init(typeId: Int) {
        self.typeId = typeId;
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
            let result = try jsonDecode.decode(TRPPlaceTypeJsonModel.self, from: data)
            let pag = paginationController(parentJson: result)
            self.Completion?(result, nil, pag);
        }catch(let tryError) {
            self.Completion?(nil, tryError as NSError, nil);
        }
    }
    
    public override func path() -> String {
        var path = TRPConfig.ApiCall.PoiCategories.link;
        if let id = typeId {
            path += "/\(id)"
        }
        return path;
    }
    
}
