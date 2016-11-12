//
//  popAnimation.swift
//  ChampionDex
//
//  Created by Jude Joseph on 11/10/16.
//  Copyright © 2016 Jude Joseph. All rights reserved.
//

import UIKit
import pop

class popAnimation: NSObject, UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view
        fromView?.tintAdjustmentMode = UIViewTintAdjustmentMode.dimmed
        fromView?.isUserInteractionEnabled = false
        
        let dimmingView = UIView()
        dimmingView.frame = (fromView?.bounds)!
        dimmingView.backgroundColor = UIColor.darkGray
        
        let toView = transitionContext.viewController(forKey: .to)?.view
        toView?.frame = CGRect(x: 0, y: 0, width: containerView.bounds.width - 90.0, height: containerView.bounds.height - 200.0)
        print("THE SIZE OF FRAME IS \(toView?.frame)")
        toView?.center = CGPoint(x: containerView.center.x, y: containerView.center.y)
        
        containerView.addSubview(dimmingView)
        containerView.addSubview(toView!)
        
        let positionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
        positionAnimation?.toValue = (containerView.center.y)
        positionAnimation?.springBounciness = 10
        positionAnimation?.completionBlock = {(animation, finished) in
            transitionContext.completeTransition(true)
        }
        
        let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.springBounciness = 20
        scaleAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 1.2, y: 1.4))
        
        let opacityAnimation = POPBasicAnimation(propertyNamed: kPOPLayerOpacity)
        opacityAnimation?.toValue = (0.2)
        
        toView?.layer.pop_add(positionAnimation, forKey: "positionAnimation")
        toView?.layer.pop_add(scaleAnimation, forKey: "scaleAnimation")
        dimmingView.layer.pop_add(opacityAnimation, forKey: "opacityAnimation")
        
        
    }
}
