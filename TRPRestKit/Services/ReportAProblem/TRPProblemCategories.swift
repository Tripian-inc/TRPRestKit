//
//  TRPProblemCategories.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.03.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
internal class TRPProblemCategories: TRPRestServices {
    
    internal override init() {}
    
    override func servicesResult(data: Data?, error: NSError?) {
        
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
            let result = try jsonDecode.decode(TRPProblemCategoriesJsonModel.self, from: data)
            self.completion?(result, nil, nil)
        } catch(let tryError) {
            self.completion?(nil, tryError as NSError, nil)
        }
        
    }
    
    override func path() -> String {
        return "problem-categories"
    }
    
    override func userOAuth() -> Bool {
        return true
    }
    
}
