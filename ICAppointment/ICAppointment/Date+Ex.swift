//
//  Date+Ex.swift
//  StorageSystem
//
//  Created by Topband on 16/8/8.
//  Copyright © 2016年 Topband. All rights reserved.
//

import Foundation

extension Date {
    
    var day: Int {
        return (Calendar.current as NSCalendar).components(.day, from: self).day!
    }
    
    var weekDay: Int {
        return (Calendar.current as NSCalendar).components(.weekday, from: self).weekday!
    }
    
    var year: Int {
        return (Calendar.current as NSCalendar).components(.year, from: self).year!
    }
    
    var month: Int {
        return (Calendar.current as NSCalendar).components(.month, from: self).month!
    }
    
    var hour: Int {
        return (Calendar.current as NSCalendar).components(.hour, from: self).hour!
    }
    
    var minute: Int {
        return (Calendar.current as NSCalendar).components(.minute, from: self).minute!
    }
    
    //date to string
    func stringDate(format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "zh_CN")//Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
    
    //获取一天最开始
    var zeroDate: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        let interval = TimeInterval(Int(calendar.date(from: components)!.timeIntervalSince1970))
        return Date.init(timeIntervalSince1970: interval)
    }
    
    //获取当天最末尾
    var endDate: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 23
        components.minute = 59
        components.second = 59
        let interval = TimeInterval(Int(calendar.date(from: components)!.timeIntervalSince1970))
        return Date.init(timeIntervalSince1970: interval)
    }
    
    //一个月第一天
    func startOfMonth() -> Date? {
        let calendar = Calendar.current
        let currentDateComponents = (calendar as NSCalendar).components([.year, .month], from: self)
        let startOfMonth = calendar.date(from: currentDateComponents)
        return startOfMonth
    }
    
    //一个月最后一天
    func endOfMonth() -> Date? {
        let calendar = Calendar.current
        if let plusOneMonthDate = dateByAddingMonths(1) {
            let plusOneMonthDateComponents = (calendar as NSCalendar).components([.year, .month], from: plusOneMonthDate)
            let endOfMonth = calendar.date(from: plusOneMonthDateComponents)?.addingTimeInterval(-1)
            return endOfMonth
        }
        return nil
    }
    
    //获取一年第一个月
    var startOfYear: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.month = 1
        components.day = self.day
        components.hour = self.hour
        components.minute = self.minute
        components.second = 0
        let interval = TimeInterval(Int(calendar.date(from: components)!.timeIntervalSince1970))
        return Date.init(timeIntervalSince1970: interval)
    }
    
    //获取一年最后一个月
    var endOfYear: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.month = 12
        components.day = self.day
        components.hour = self.hour
        components.minute = self.minute
        components.second = 0
        let interval = TimeInterval(Int(calendar.date(from: components)!.timeIntervalSince1970))
        return Date.init(timeIntervalSince1970: interval)
    }
    
    func dateByAddinYears(_ yearsToAdd: Int) -> Date? {
        let calendar = Calendar.current
        var months = DateComponents()
        months.year = yearsToAdd
        return (calendar as NSCalendar).date(byAdding: months, to: self, options: NSCalendar.Options.init(rawValue: 0))
    }
    
    func dateByAddingMonths(_ monthsToAdd: Int) -> Date? {
        let calendar = Calendar.current
        var months = DateComponents()
        months.month = monthsToAdd
        return (calendar as NSCalendar).date(byAdding: months, to: self, options: NSCalendar.Options.init(rawValue: 0))
    }
    
    func dateByAddingDays(_ daysToAdd: Int) -> Date? {
        let calendar = Calendar.current
        var days = DateComponents()
        days.day = daysToAdd
        return (calendar as NSCalendar).date(byAdding: days, to: self, options: NSCalendar.Options.init(rawValue: 0))
    }
    
    func dateByAddingHours(_ hour: Int) -> Date? {
        let calendar = Calendar.current
        var days = DateComponents()
        days.hour = hour
        return (calendar as NSCalendar).date(byAdding: days, to: self, options: NSCalendar.Options.init(rawValue: 0))
    }
}
