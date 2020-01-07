//
//  UITextField+Extension.swift
//  HHUtils
//
//  Created by master on 2020/1/7.
//

import Foundation
import UIKit


public extension UITextField{
    
    func setPlaceHolderColor(_ color:UIColor){
        
        
        guard let ivar = class_getInstanceVariable(UITextField.self, "_placeholderLabel") else {return}
        let label = object_getIvar(self, ivar) as? UILabel
        label?.textColor = color
    }
    
    
    func setPlaceHolderFont(_ font:UIFont){
        guard let ivar = class_getInstanceVariable(UITextField.self, "_placeholderLabel") else {return}
        let label = object_getIvar(self, ivar) as? UILabel
        label?.font = font
    }
    
    
}

