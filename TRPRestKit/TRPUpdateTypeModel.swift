//
//  TRPUpdateTypeModel.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 29.06.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
public enum TRPUpdateTypeModel:Int {
    case added, updated, deleted;
    
    static func convert(_ value: String) -> TRPUpdateTypeModel? {
        var order = 0;
        while let item = TRPUpdateTypeModel.init(rawValue: order) {
            if "\(item)" == value {
                return item
            }
            order += 1;
        }
        return nil
    }
}
