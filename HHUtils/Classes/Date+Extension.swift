//
//  Date+Extension.swift
//  HHUIKit
//
//  Created by master on 2020/1/2.
//  Copyright © 2020 com.ian.Test. All rights reserved.
//

import Foundation


public extension Date{
    
    
    
    
    ///年
    var year:Int{
        let calendar = Calendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.year ?? 0
    }
    ///月
    var month:Int{
        let calendar = Calendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.month ?? 0
    }
///    天
    var day:Int{
        let calendar = Calendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.day ?? 0
    }
   ///星期几
    var weakDay:Int{
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    //当月的天数
    var daysInMonth:Int{
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        return range?.length ?? 30
   
    }
    
    ///本月的第一天是星期几
    var firstWeekday:Int{
         //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: self) ?? 0
        return firstWeekDay - 1
    
    }
    ///是否是今天
    var isToday:Bool{
        
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
    }
    ///是否是本月
    var isThisMonth:Bool{
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month
    }
    
    
    func befor(timeStamp:String)->String{
        let timeDate = timeStamp.date
        let currentDate = NSDate()
        
        let timeInterval = currentDate.timeIntervalSince(timeDate)
        
        var temp:Double = 0
        
        var result:String = ""
        
        if timeInterval/60 < 1 {
            
            result = "刚刚"
            
        }else if (timeInterval/60) < 60{
            
            temp = timeInterval/60
            
            result = "\(Int(temp))分钟前"
            
        }else if timeInterval/60/60 < 24 {
            
            temp = timeInterval/60/60
            
            result = "\(Int(temp))小时前"
            
        }else if timeInterval/(24 * 60 * 60) < 30 {
            
            temp = timeInterval / (24 * 60 * 60)
            
            result = "\(Int(temp))天前"
            
        }else if timeInterval/(30 * 24 * 60 * 60)  < 12 {
            
            temp = timeInterval/(30 * 24 * 60 * 60)
            
            result = "\(Int(temp))个月前"
            
        }else{
            
            temp = timeInterval/(12 * 30 * 24 * 60 * 60)
            
            result = "\(Int(temp))年前"
            
        }
        
        return result
    }
    
    ///当前时间和其他时间的相隔天数
    func diferentFrom(date:Date)->Double{
        let interval = self.timeIntervalSince(date)
        return interval/86400
    }
    
    
    
    
    ///yyyy-MM-dd HH:mm:ss 年月日时分秒
    var yyyyMMddHHmmss:String{
        return toString()
    }
    
    
    ///yyyy-MM-dd 年月日
    var yyyyMMdd:String{
        return toString("yyyy-MM-dd")
    }
    
    ///年月日小时分钟
    var yyyyMMddHHmm:String{
        return toString("yyyy-MM-dd HH:mm")
    }
    
    ///年月
    var yyyyMM:String{
        return toString("yyyy-MM")
    }
    
    
    
    
    func toString(_ formate:String = "yyyy-MM-dd HH:mm:ss")->String{
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = formate
        let date = formatter.string(from:self)
        return date
    }
    
    
    
    
    
    
}
