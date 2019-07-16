//
//  TRPTime.swift
//  TRPRestKit
//
//  Created by Evren Yaşar on 19.05.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//
import Foundation


/// This struct has Date and Time formats.
/// To convert string to Date/Time.
/// Date is `yyyy-mm-dd`
/// Time is `hh:mm`
public struct TRPTime {
    
    /// A Date value. Closer uses a `yyyy-MM-dd HH:mm`style to convert.
    public var formated: Date? {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let tz = TimeZone(identifier: "UTC") {
            formatter.timeZone = tz
        }
        return  formatter.date(from: "\(date) \(time)")
    }
    
    /// A String value. Readable value of date
    public var date: String = ""
    /// A String value. Readable value of time
    public var time: String = ""
    
    
    /// Initilizes a new TRPTime with Int values.
    ///
    /// - Parameters:
    ///   - year: years such as 2019
    ///   - month: month such as 12
    ///   - day: day such as 29
    ///   - hours: hours such as 14
    ///   - min: min such as 00
    public init(year:Int, month:Int, day:Int, hours:Int, min:Int) {
        let formatedMonth = String(format: "%02d", month)
        let formatedDay = String(format: "%02d", day)
        date = String(year) + "-" + formatedMonth + "-" + formatedDay;
        time = String(format: "%02i:%02i", hours, min)
    }
    
    /// Initilizes a new TRPTime with string values.
    ///
    /// - Parameters:
    ///   - date: yyyy-mm-dd
    ///   - time: hh:mm
    public init(date: String, time: String) {
        self.date = date
        self.time = time
    }
    
    
    /// Initilizes a new TRPTime with date
    ///
    /// - Parameter date: Date object will be parsed Date/Time.
    public init(date: Date) {
        var calendar = Calendar.current
        if let tz = TimeZone(identifier: "UTC") {
            calendar.timeZone = tz
        }
        let year =
            calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let min = calendar.component(.minute, from: date)
        self.init(year: year, month: month, day: day, hours: hour, min: min)
    }
}
