//
//  TRPRestDeneme.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 13.01.2020.
//  Copyright © 2020 Evren Yaşar. All rights reserved.
//

import Foundation
import TRPFoundationKit
public class TRPRestDeneme {
    
    public init() {
        print("[RestDeneme] init")
    }
    
    public func level1() {
        print("[RestDeneme] Level1 start")
        let ksadasd = TRPCities(cityId: 1)
        print("[RestDeneme] Level1 end \(ksadasd.parameters())")
    }
    
    public func level2() {
        print("[RestDeneme] Level2")
        let settings = TRPTripSettings(cityId: 1, arrivalTime: TRPTime(date: "", time: ""), departureTime: TRPTime(date: "", time: ""))
        print("[RestDeneme] Level2 end")
    }
    
    public func level3() {
        print("[RestDeneme] Level3")
    }
    
    public func foundationDeneme() {
        print("[RestDeneme] start foundationDeneme")
        let missingApiKeys = TRPApiKeyController.checkMissingApiKeys([.mglMapboxAccessToken,.trpApiKey])
        print("[RestDeneme] Result \(missingApiKeys)")
        print("[RestDeneme] end foundationDeneme")
    }
}
