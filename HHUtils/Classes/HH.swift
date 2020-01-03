//
//  HH.swift
//  HHUIKit
//
//  Created by master on 2020/1/2.
//  Copyright © 2020 com.ian.Test. All rights reserved.
//

import Foundation
import UIKit


public class HH{
    
    

//    当前的ViewController
    
   public class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
         if let nav = base as? UINavigationController {
             return currentViewController(base: nav.visibleViewController)
         }
         if let tab = base as? UITabBarController {
             return currentViewController(base: tab.selectedViewController)
         }
         if let presented = base?.presentedViewController {
             return currentViewController(base: presented)
         }
         return base
    }
    
    
    public class func dissmissAll(complition:(()->Void)?){
        guard var topVC = UIApplication.shared.keyWindow?.rootViewController else{
            complition?()
            return
        }
        var list:[UIViewController] = []
        while true {
            if topVC.presentedViewController != nil {
                list.append(topVC.presentedViewController!)
            }else if topVC is UINavigationController{
                topVC = topVC as! UINavigationController
            }else if topVC is UITabBarController{
                topVC = topVC as! UITabBarController
            }
        }
        
        guard list.count > 0 else {
            complition?()
            return
        }
        for (idx,vc) in list.enumerated(){
            
            if idx == 0 {
                if vc is UINavigationController{
                    (vc as! UINavigationController).popToRootViewController(animated: false)
                }
                vc.dismiss(animated:false, completion: complition)
            }else{
                if vc is UINavigationController{
                    (vc as! UINavigationController).popToRootViewController(animated: false)
                }
                vc.dismiss(animated:false, completion: nil)
                
                
            }
        }
        
    }
    
    
    
    
    
    
    
    
    @available(iOS 11.0, *)
    public static let bottomSpace = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
    public static let navHeight = UINavigationBar.appearance().height
    public static let statuBarheight = UIApplication.shared.statusBarFrame.height
    public static let navAndStatusheight = HH.navHeight + HH.statuBarheight
    
    public static let infoDictionary = Bundle.main.infoDictionary
   //App 名称
   public static let appDisplayName: String = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
   // Bundle Identifier
   public static let bundleIdentifier:String = Bundle.main.bundleIdentifier!
   // App 版本号
   public static let appVersion:String = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String
   //Bulid 版本号
   public static let buildVersion : String = Bundle.main.infoDictionary! ["CFBundleVersion"] as! String
   //ios 版本
   public static let iOSVersion: String = UIDevice.current.systemVersion
   //设备 udid
   public static let identifierNumber = UIDevice.current.identifierForVendor!.uuidString
   //设备名称
   public static let systemName = UIDevice.current.systemName
   // 设备型号
   public static let model = UIDevice.current.model
   //设备区域化型号
   public static let localizedModel = UIDevice.current.localizedModel
    
    
}



