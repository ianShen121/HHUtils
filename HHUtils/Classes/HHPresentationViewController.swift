//
//  HHPresentationViewController.swift
//  HHUIKit
//
//  Created by master on 2020/1/2.
//  Copyright © 2020 com.ian.Test. All rights reserved.
//

import UIKit


public class HHPresentationViewController: UIPresentationController {

    var showDirection:ShowDirection = .fromLeft
    var config:HHPresntConfiguration = HHPresntConfiguration()
    lazy var dimmingView:UIView = {
        let v = UIView()
        v.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapDimingView)))
        v.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        return v
        
    }()
    
    @objc
    private func tapDimingView(){
        if config.isDimmingDismiss{
            self.presentedViewController.dismiss(animated: true, completion: nil)
        }
    }

    
    
    
    
    
    public override var frameOfPresentedViewInContainerView: CGRect{
        return config.frame
    }
    
    
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        presentedViewController.modalPresentationStyle = .custom
    }
    
   
    
    
    public override func presentationTransitionWillBegin() {
        guard let cv = self.containerView,let cordinator = self.presentedViewController.transitionCoordinator else {
            return
        }
        
        presentedViewController.view.layer.cornerRadius = config.cornerRadius
        dimmingView.frame = config.dimmingViewFrame
        cv.addSubview(dimmingView)
        cordinator.animate(alongsideTransition: { (ctx) in

        }, completion: nil)
        
        
        
    }
    
    
    
    public override func presentationTransitionDidEnd(_ completed: Bool) {
        
    }
    
    
    
    public override func dismissalTransitionWillBegin() {
        guard let cordinator = self.presentedViewController.transitionCoordinator else {
            return
        }

        cordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0
            
        }, completion: nil)
    }
    
    
    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed{
            dimmingView.removeFromSuperview()
        }
    }
    
    
    public override func containerViewWillLayoutSubviews() {
        self.dimmingView.center = self.containerView!.center
        self.dimmingView.bounds = self.containerView!.bounds
        
//        let width = self.containerView!.frame.width * 2 / 3, height = self.containerView!.frame.height * 2 / 3
//        self.presentedView?.center = self.containerView!.center
//        self.presentedView?.bounds = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    
}


