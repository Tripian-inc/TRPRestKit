//
//  Pagination.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 25.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public enum Pagination{
    case continuing
    case completed
    
    public var readable: String  {
        switch self {
        case .continuing:
            return "continuing"
        case .completed:
            return "completed"
        }
    }
}
