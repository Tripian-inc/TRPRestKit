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
    
    var model: TRPTripInfoModel?
    
    var cityId: Int? {
        return model?.city.id ?? nil
    }
    
    var hash: String {
        return model?.hash ?? ""
    }
    
    func getDay(order: Int) -> TRPDailyPlanInfoModel? {
        guard let plans = model?.dailyPlans else {
            return nil
        }
        if plans.count < order {
            return nil
        }
        return plans[order]
    }
    
}
