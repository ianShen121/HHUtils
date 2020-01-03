//
//  HHUIConst.swift
//  HHUIKit
//
//  Created by master on 2019/12/31.
//  Copyright © 2019 com.ian.Test. All rights reserved.
//

import Foundation
import UIKit


public let HHSCREEN_HEIGHT = UIScreen.main.bounds.height
public let HHSCREEN_WIDTH = UIScreen.main.bounds.width





public func HHLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\n\(fileName):(\(lineNum))-\(messsage)")
        
    #endif
}

