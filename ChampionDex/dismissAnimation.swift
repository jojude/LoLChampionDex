//
//  dismissAnimation.swift
//  ChampionDex
//
//  Created by Jude Joseph on 11/10/16.
//  Copyright © 2016 Jude Joseph. All rights reserved.
//

import UIKit
import pop

class dismissAnimation: NSObject, UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toVC = transitionContext.viewController(forKey: .to)?.view
        toVC?.tintAdjustmentMode = .normal
        toVC?.isUserInteractionEnabled = true
        
        let fromVC = transitionContext.viewController(forKey: .from)?.view
        var dimmingView = UIView()
        
        (transitionContext.containerView.subviews as NSArray).enumerateObjects({(vc, idx, stop) -> Void in
            let view = vc as? UIView
            
            if (view?.layer.opacity)! < Float(1) {
                dimmingView = view!
            }
        })
        
        let opacityAnimation = POPBasicAnimation(propertyNamed: kPOPLayerOpacity)
        opacityAnimation?.toValue = (0.0)
        
        let offscreenAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPositionY)
        let value = Int(-((fromVC?.layer.position.y)!))
        offscreenAnimation?.toValue = (Float(value))
        offscreenAnimation?.completionBlock = {(animation, finished) in
            transitionContext.completeTransition(true)
        }
        
        fromVC?.layer.pop_add(offscreenAnimation, forKey: "offscreenAnimation")
        dimmingView.layer.pop_add(opacityAnimation, forKey: "opacityAnimation")
        
    }
}
