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
    
    public var formated: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return  formatter.date(from: "\(date) \(time)")
    }
    
    var date: String = "";
    var time: String = ""
    
    public init(year:Int, month:Int, day:Int, hours:Int, min:Int) {
        let formatedMonth = String(format: "%02d", month)
        let formatedDay = String(format: "%02d", day)
        date = String(year) + "-" + formatedMonth + "-" + formatedDay;
        time = String(format: "%02i:%02i", hours, min)
    }
    
    /// Set Time with Strign
    ///
    /// - Parameters:
    ///   - date: yyyy-mm-dd
    ///   - time: hh:mm
    public init(date: String, time: String) {
        self.date = date
        self.time = time
    }
}
