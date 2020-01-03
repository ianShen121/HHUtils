//
//  UIViewController+Extension.swift
//  HHUIKit
//
//  Created by master on 2020/1/2.
//  Copyright © 2020 com.ian.Test. All rights reserved.
//

import Foundation
import UIKit

public enum PushAnimationType:String{
    
    case 淡化 = "fade"
    case 推进 = "push"
    case 滑入 = "moveIn"
    case 滑出 = "reveal"
    case 立方体 = "cube"
    case 吮吸 = "suckEffect"
    case 翻转 = "oglFlip"
    case 波纹 = "rippleEffect"
    case 翻页 = "pageCurl"
    case 反翻页 = "pageUnCurl"
    case 开镜头 = "cameraIrisHollowOpen"
    case 关镜头 = "cameraIrisHollowClose"
}

//public enum PushAnimationSubType:String{
//
//
//}



public extension UIViewController{
    
    static var bundle:Bundle?{
        let podBundle = Bundle.init(for: self.classForCoder())
        guard let bundleUrl = podBundle.url(forResource: "HHKit", withExtension: "bundle") else {return nil}
        return Bundle.init(url: bundleUrl)
    }
    
    
    
    

    func push(_ vc:UIViewController,type:PushAnimationType = .推进,subType:CATransitionSubtype = .fromLeft,duration:CGFloat = 0.5){
        
        let transition = CATransition()
        transition.duration = CFTimeInterval(duration)
        transition.type = CATransitionType(rawValue: type.rawValue)
        transition.subtype = subType
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func pushDefault(_ vc:UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func present(_ vc:UIViewController,config:HHPresntConfiguration){
        PresentHelper.show(using: vc, in: self, config: config)
    }
    
    
    
    
    
}






