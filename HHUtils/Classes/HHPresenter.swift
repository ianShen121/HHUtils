//
//  HHPresenter.swift
//  HHUIKit
//
//  Created by master on 2020/1/2.
//  Copyright © 2020 com.ian.Test. All rights reserved.
//

import UIKit
public let PresentHelper = HHPresenter.shared

public class HHPresenter:NSObject{
    
    fileprivate(set) var presentViewController:HHPresentationViewController?
    fileprivate var configuration:HHPresntConfiguration = HHPresntConfiguration()
    static let shared = HHPresenter()
    
    public override init() {
        
    }
    

     public func show(using presentedViewController:UIViewController,in presentingViewCotroller:UIViewController,config:HHPresntConfiguration=HHPresntConfiguration()){
        
        
        self.configuration = config
        let preVC = HHPresentationViewController.init(presentedViewController: presentedViewController, presenting: presentingViewCotroller)
        preVC.config = config
        self.presentViewController = preVC
        presentedViewController.transitioningDelegate = self
        presentingViewCotroller.present(presentedViewController, animated: true, completion: nil)
    }
    
    
    public func show(using presentedViewController:UIViewController,in presentingViewCotroller:UIViewController,configHannddler:(()->HHPresntConfiguration?)?){
        var config:HHPresntConfiguration!
        if configHannddler != nil && configHannddler!() != nil{
            config = configHannddler!()
        }else{
            config = HHPresntConfiguration()
        }
        self.show(using: presentedViewController, in: presentingViewCotroller, config: config)
    }

}


extension HHPresenter:UIViewControllerTransitioningDelegate{
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self.presentViewController
    }
    
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator.init(showType: .present, configuration: configuration)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator.init(showType: .dismiss, configuration: configuration)
    }
    
    
    
}

