//
//  Pagination.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public enum Pagination{
    
    
    //case continuing(nextPage:String)
    case continues(String)
    case completed
    
    public var readable: String  {
        switch self {
        case .continues:
            return "continues"
        case .completed:
            return "completed"
        }
    }
    
}
extension Pagination: Equatable {
    
    public static func ==(lhs: Pagination, rhs:Pagination) -> Bool {
        
        switch (lhs,rhs) {
        case (.completed, .completed):
            return true
        case (.continues, .continues):
            return true
        default:
            return false
        }
        
    }
}
