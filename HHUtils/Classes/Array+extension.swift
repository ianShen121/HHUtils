//
//  Array+extension.swift
//  HHUIKit
//
//  Created by master on 2020/1/2.
//  Copyright © 2020 com.ian.Test. All rights reserved.
//

import Foundation


public extension Array{
    
    
    subscript(safe index: Int ) -> Element? {
       return indices.contains(index) ? self[index] : nil
    }
    

    
    
    ///转成JSON
    var json:String{
        if (!JSONSerialization.isValidJSONObject(self)) {
              HHLog("无法解析出JSONString")
              return ""
          }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {return ""}
        guard let JSONString = NSString(data:data,encoding: String.Encoding.utf8.rawValue) else {return ""}
          return JSONString as String
    }
    
    
}


//MARK:删除
extension Array where Element : Equatable {
    public func indexes(of item: Element) -> [Int] {
        var indexes = [Int]()
        for index in 0..<count where self[index] == item {
            indexes.append(index)
        }
        return indexes
    }
    
    
    /// 获取元素首次出现的位置
    ///
    /// - Parameter item: 元素
    /// - Returns: 索引值
    public func firstIndex(of item: Element) -> Int? {
        for (index, value) in lazy.enumerated() where value == item {
            return index
        }
        return nil
    }
    
    
    /// 获取元素最后出现的位置
    ///
    /// - Parameter item: 元素
    /// - Returns: 索引值
    public func lastIndex(of item: Element) -> Int? {
        return indexes(of: item).last
    }
    
    
    /// 删除数组中的指定元素
    ///
    /// - Parameter object: 元素
    public mutating func remove(object:Element) -> Void {
        for idx in self.indexes(of: object).reversed() {
            self.remove(at: idx)
        }
    }

}
