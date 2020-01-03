//
//  UIImageView+Extension.swift
//  HHUIKit
//
//  Created by master on 2020/1/2.
//  Copyright © 2020 com.ian.Test. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView{
    
    
    var imageName:String?{
        get{
            return ""
        }
        set{
            guard let name = newValue else {return}
            guard name.isNotEmpty else {return}
            self.image = UIImage.init(named: name)
            
        }
        
        
    }
    
    /// 设置图片圆角

    func circleImage() {

        /// 建立上下文

        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)

        /// 获取当前上下文

        let ctx = UIGraphicsGetCurrentContext()

        /// 添加一个圆，并裁剪

        ctx?.addEllipse(in: self.bounds)

        ctx?.clip()

        /// 绘制图像

        self.draw(self.bounds)

        /// 获取绘制的图像

        let image = UIGraphicsGetImageFromCurrentImageContext()

        /// 关闭上下文

        UIGraphicsEndImageContext()

        DispatchQueue.global().async {

            self.image = image

        }

    }


    
}
