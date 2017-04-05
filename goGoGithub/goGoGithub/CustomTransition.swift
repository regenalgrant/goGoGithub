//
//  CustomTransition.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/5/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval
    init(duration: TimeInterval = 0.5) {
        self.duration = duration
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        
        
        transitionContext.containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0.0
        UIView.animate(withDuration: self.duration, animations: {
            
            toViewController.view.alpha = 0.1
            
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }


}
