//
//  NavigationViewController.swift
//  NavigationBar
//
//  Created by zengdaqian on 16/8/2.
//  Copyright © 2016年 zengdaqian. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    var navigationDelegate: NavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationDelegate = NavigationDelegate(navigationController: self)
        
        if let vc = viewControllers[0] as? NavigationStackController {
            vc.navigationController?.navigationBar.barTintColor = vc.navigationBarColor
            vc.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: vc.navigationBarTitleColor]
            vc.navigationController?.navigationBar.tintColor = vc.tintColor
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createTransparentImage(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let blank = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return blank
    }
    

}

class NavigationDelegate: NSObject, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    weak var navigationController: UINavigationController?
    
    var interactionController = UIPercentDrivenInteractiveTransition()
    var interactive = false
    
    var pangesture: UIPanGestureRecognizer?
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController?.delegate = self
        pangesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGestureRecognize(_:)))
        pangesture?.delegate = self
        self.navigationController?.view.addGestureRecognizer(pangesture!)
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
    }
    
    func handlePanGestureRecognize(gesture: UIPanGestureRecognizer) {
        
        let width = self.navigationController?.view.bounds.size.width ?? 1.0
        let translate = gesture.translationInView(gesture.view)
        let percent: CGFloat = translate.x / width
        
        switch gesture.state {
        case .Began:
            self.interactive = true
            self.navigationController?.popViewControllerAnimated(true)
        case .Changed:
            self.interactionController.updateInteractiveTransition(percent)
        case .Cancelled, .Ended:
            let velocity = gesture.velocityInView(gesture.view)
            if percent > 0.3 && velocity.x > 0 {
                self.interactionController.finishInteractiveTransition()
            } else {
                self.interactionController.cancelInteractiveTransition()
            }
            self.interactive = false
        default:
            self.interactive = false
            return
        }
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if self.navigationController?.viewControllers.count <= 1 {
            return false
        }
        
        return true
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        if let vc = viewController as? NavigationStackController {
            navigationController.setNavigationBarHidden(vc.navigationBarHidden, animated: animated)
        }
        
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = NavigationControllerTransition(operation: operation)
        
        return transition
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? interactionController : nil
    }
}

class NavigationControllerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let presenting: Bool
    
    init(operation: UINavigationControllerOperation) {
        presenting = operation == .Push ? true : false
        super.init()
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromV = transitionContext.viewForKey(UITransitionContextFromViewKey) else { fatalError() }
        guard let toV = transitionContext.viewForKey(UITransitionContextToViewKey) else { fatalError() }
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? NavigationStackController else { fatalError() }
        guard let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? NavigationStackController else { fatalError() }
        
        
        
        if presenting {
            toV.frame.origin.x = toV.frame.width
            transitionContext.containerView()?.addSubview(toV)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
                toV.frame.origin.x = 0
                fromV.frame.origin.x = -fromV.frame.width
                fromVC.navigationController?.navigationBar.barTintColor = toVC.navigationBarColor
                fromVC.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: toVC.navigationBarTitleColor]
                fromVC.navigationController?.navigationBar.tintColor = toVC.tintColor
                }, completion: { (finished) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                    if transitionContext.transitionWasCancelled() {
                        fromVC.navigationController?.navigationBar.barTintColor = fromVC.navigationBarColor
                        fromVC.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: fromVC.navigationBarTitleColor]
                        fromVC.navigationController?.navigationBar.tintColor = fromVC.tintColor
                    } else {
                        toVC.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: toVC.navigationBarTitleColor]
                        toVC.navigationController?.navigationBar.tintColor = toVC.tintColor
                    }
            })
        } else {
            toV.frame.origin.x = -toV.frame.width
            transitionContext.containerView()?.addSubview(toV)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                toV.frame.origin.x = 0
                fromV.frame.origin.x = fromV.frame.width
                fromVC.navigationController?.navigationBar.barTintColor = toVC.navigationBarColor
                }, completion: { (finished) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                    if transitionContext.transitionWasCancelled() {
                        fromVC.navigationController?.navigationBar.barTintColor = fromVC.navigationBarColor
                        fromVC.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: fromVC.navigationBarTitleColor]
                        fromVC.navigationController?.navigationBar.tintColor = fromVC.tintColor
                    } else {
                        toVC.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: toVC.navigationBarTitleColor]
                        toVC.navigationController?.navigationBar.tintColor = toVC.tintColor
                    }
            })
        }
        
    }
    
}


protocol NavigationStackController {
    
    var navigationBarColor: UIColor { get }
    
    var navigationBarTitleColor: UIColor { get }
    
    var tintColor: UIColor { get }
    
    var navigationBarHidden: Bool { get }
    
    var navigationController: UINavigationController? { get }
}




