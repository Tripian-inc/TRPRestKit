//
//  TripHolder.swift
//  TRPRestKitiOS.Tests
//
//  Created by Evren Yaşar on 23.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPRestKit
class TripHolder {
    
    static let shared: TripHolder = TripHolder()
    
    var model: TRPTripModel?
    
    var cityId: Int? {
        return model?.city.id ?? nil
    }
    
    var hash: String {
        return model?.tripHash ?? ""
    }
    
    func getDay(order: Int) -> TRPPlansInfoModel? {
        guard let plans = model?.plans else {
            return nil
        }
        if plans.count < order {
            return nil
        }
        return plans[order]
    }
    
}
