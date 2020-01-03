//
//  HHButton.swift
//  HHUIKit
//
//  Created by master on 2019/12/31.
//  Copyright © 2019 com.ian.Test. All rights reserved.
//

import UIKit



@IBDesignable

open class HHButton: UIButton {
    
    
    var timer:DispatchSourceTimer?
    
    override open var isSelected: Bool{
        didSet{
            guard let _ = hhSelectedBackgroundColor else {return}
            if isSelected {
                self.backgroundColor = hhSelectedBackgroundColor
            }else{
                self.backgroundColor = normalBackgroundColor
            }
            
            
        }
    }
    
    override open var isEnabled: Bool{
        didSet{
            guard let _ = hhDisnabledBackgroundColor else {return}
            if isEnabled{
                guard let _ = hhSelectedBackgroundColor else {return}
                if isSelected {
                    self.backgroundColor = hhSelectedBackgroundColor
                }else{
                    self.backgroundColor = normalBackgroundColor
                }
            }else{
                self.backgroundColor = hhDisnabledBackgroundColor
            }
            
            
        }
    }
    
    
    @IBInspectable
    public var normalBackgroundColor:UIColor?{
        didSet{
            self.backgroundColor = normalBackgroundColor
        }
    }
    @IBInspectable
    public var hhSelectedBackgroundColor:UIColor?
    @IBInspectable
    public var hhDisnabledBackgroundColor:UIColor?
    
    
    @IBInspectable
    public var countDownNum:Double = 60{
        didSet{
            self._countDownNum = countDownNum
        }
    }
    
    @IBInspectable
    public var normalTitle:String?{
        didSet{
            self.setTitle(normalTitle, for: .normal)
        }
    }
    

    
    @IBInspectable
    public var countDownColor:UIColor = UIColor.lightGray
    
    var isCountting:Bool = false
    
    
    
    var _countDownNum:Double = 60
    
    
    
    open func countDown(){
        
        isCountting = true
        
        if isCountting{
           
        }
        
        self.isEnabled = false
        
        self.timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        
        timer?.schedule(deadline: .now(), repeating: 1)
        timer?.setEventHandler {
            
            if self._countDownNum == 0 {
                self.isEnabled = true
                self.isCountting = false
                self._countDownNum = self.countDownNum
                self.setTitle(self.normalTitle, for: .normal)
                self.timer?.cancel()
            }else{
                
                self._countDownNum -= 1
                DispatchQueue.main.async {
                    self.setTitle("\(Int(self._countDownNum))S", for: .normal)
                    
                }
            }
    
         
        }
        self.timer?.resume()
        
        
    }
        
        
        
        
    
    

}
