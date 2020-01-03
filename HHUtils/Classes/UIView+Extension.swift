//
//  UIView+Extension.swift
//  HHUIKit
//
//  Created by master on 2019/12/31.
//  Copyright © 2019 com.ian.Test. All rights reserved.
//

import Foundation
import UIKit






public extension UIView{
    

    var snapshot: UIImage {
         UIGraphicsBeginImageContext(self.bounds.size)
         self.layer.render(in: UIGraphicsGetCurrentContext()!)
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         return image!
     }
    
    
    
    func removeAllSubview(){
        self.subviews.forEach({ (v) in
            v.removeFromSuperview()
        })
        
    }
    

    
    
    ///毛玻璃
    func blurEffectViewWithAlpha(alpha:CGFloat) -> Void
    {
        let effect = UIBlurEffect.init(style: UIBlurEffect.Style.light)
        let effectView = UIVisualEffectView.init(effect: effect)
        effectView.frame = self.bounds
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
    
    ///等比例缩放
    func scale(_ size:CGFloat){
        
        self.transform = self.transform.scaledBy(x: size, y: size);
    }
    
    ///旋转
    func rotate(_ rotation:CGFloat){
        self.transform = CGAffineTransform(rotationAngle: rotation);
    }
    
    ///翻转
    func flip(isHorizontal:Bool){
         if (isHorizontal)
            {
                // 水平
                self.transform = self.transform.scaledBy(x: -1.0, y: 1.0);
            }
            else
            {
                // 垂直
                self.transform = self.transform.scaledBy(x: 1.0, y: -1.0);
        
            }
    }
    
    
}







//MARK:--layer

public extension UIView{
    @IBInspectable
    var cornerRadius:CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var borderWidth:CGFloat{
        
        get{
            return self.layer.borderWidth
        }
        
        set{
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor:UIColor?{
        
        get{
            guard let c = self.layer.borderColor else {return nil}
            return UIColor.init(cgColor: c)
        }
        
        set{
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var hexBorderColor:String?{
        get{
            return nil
        }
        
        set{
            self.borderColor = newValue?.color
        }
    }
    
    
    
    
}








//MARK:--Frame
public extension UIView{
    

    var x:CGFloat{
        get{
            return self.frame.minX
        }
        set{
            self.frame.origin.x = newValue
        }
    }
    
    var y:CGFloat{
        get{
            return self.frame.minY
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    
    
    var width:CGFloat{
        get{
            return self.frame.width
        }
        
        set{
            self.frame.size.width = newValue
        }
    }
    
    var height:CGFloat{
        get{
            return self.frame.height
        }
        set{
            self.frame.size.height = newValue
        }
    }
    
    
    var midX:CGFloat{
        get{
            return self.frame.midX
        }
        
        set{
            self.x = (self.width - newValue)/2
        }
    }
    
    var midY:CGFloat{
        get{
            return self.frame.midY
        }
        
        set{
            self.y = (self.height-newValue)/2
        }
    }
    
    
    var maxX:CGFloat{
        get{
            return self.frame.maxX
        }
        set{
            self.x = self.width-newValue
        }
    }
    
    
    var maxY:CGFloat{
        get{
            return self.frame.maxY
        }
        set{
            self.y = self.height - newValue
        }
    }
    
    
    
    
}
