//
//  Dictionary+Extension.swift
//  HHUIKit
//
//  Created by master on 2020/1/2.
//  Copyright © 2020 com.ian.Test. All rights reserved.
//

import Foundation


public extension Dictionary{
    var json:String{
        
        if (!JSONSerialization.isValidJSONObject(self)) {
                print("无法解析出JSONString")
                return ""
            }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {return ""}
        guard let JSONString = NSString(data:data ,encoding: String.Encoding.utf8.rawValue) else {return ""}
        return JSONString as String
        
    }
    
    
    
}
