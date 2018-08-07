//
//  TRPTime.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 19.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//


//MOVE
import Foundation
public struct TRPTime {
    var date: String = "";
    var time: String = ""
    
    public init(year:Int, month:Int, day:Int, hours:Int, min:Int, seconds:Int) {
        
        date = String(year) + "-" + String(month) + "-" + String(day);
        time = String(format: "%i:%02i:%02i", hours, min, seconds)
    }
    
    /// Set Time with Strign
    ///
    /// - Parameters:
    ///   - date: yyyy-mm-dd
    ///   - time: hh:mm:ss
    public init(date: String, time: String) {
        self.date = date
        self.time = time
    }
}
