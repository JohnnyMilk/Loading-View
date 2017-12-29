//
//  MLLoadingViewController.swift
//  SeeU Pay
//
//  Created by Johnny Wang on 2017/11/24.
//  Copyright © 2017年 Johnny Wang. All rights reserved.
//

import UIKit

class MLLoadingView: UIView, CAAnimationDelegate {
    let dotView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 33.0, height: 33.0)))
    
    init() {
        super.init(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 75.0, height: 75.0)))
        drawloadingView()
        drawProgressDot()
        do360DegreesRotation()
    }
    
    init(text: String) {
        super.init(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 154.0, height: 134.0)))
        drawloadingView()
        drawProgressDot()
        drawTextLabel(text: text)
        do360DegreesRotation()
    }
    
    private override init(frame: CGRect) { super.init(frame: CGRect.zero)}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawloadingView() {
        let topGap: CGFloat = 20.0
        
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        layer.cornerRadius = 5.0
        
        layoutIfNeeded()
        dotView.center = center
        dotView.frame.origin.y = topGap
        addSubview(dotView)
    }
    
    private func drawProgressDot() {
        let dotAlpha: [CGFloat] = [1.0, 0.8, 0.6, 0.4, 0.2, 0.1, 0.05]
        let dotSize = CGSize(width: 5.0, height: 5.0)
        let dotRadius: CGFloat = dotSize.width / 2.0
        let viewRadius: CGFloat = (dotView.frame.width / 2.0) - (dotSize.width / 2.0)
        let diameter: CGFloat = CGFloat.pi / 180.0
        let degreeIteration: CGFloat = -36.0
        
        for i in 0...dotAlpha.count - 1 {
            let dotCenter = CGPoint(x: (dotView.center.x - dotView.frame.origin.x) + (viewRadius * cos(diameter * CGFloat(i) * degreeIteration)), y: (dotView.center.y - dotView.frame.origin.y) + (viewRadius * sin(diameter * CGFloat(i) * degreeIteration)))
            let dot = UIView(frame: CGRect(origin: CGPoint.zero, size: dotSize))
            dot.center = dotCenter
            dot.layer.cornerRadius = dotRadius
            dot.backgroundColor = UIColor.white.withAlphaComponent(dotAlpha[i])
            
            dotView.addSubview(dot)
        }
        
        dotView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    private func do360DegreesRotation(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat.pi * 2.0
        rotateAnimation.duration = duration
        rotateAnimation.delegate = self
        
        dotView.layer.add(rotateAnimation, forKey: nil)
    }
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        do360DegreesRotation()
    }
    
    private func drawTextLabel(text: String) {
        let label = UILabel(frame: CGRect.zero)
        
        label.text = text
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 8.0, lineHeightMultiple: 0.0)
        label.font = UIFont(name: "HelveticaNeue", size: 14.0)
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 74.0).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        layoutIfNeeded()
        
        let loadingViewSize = CGSize(width: frame.width, height: label.frame.origin.y + label.frame.height + 26.0)
        frame = CGRect(origin: CGPoint.zero, size: loadingViewSize)
    }

}

class MLLoadingViewController: UIViewController, UIViewControllerTransitioningDelegate {
    private var loadingView: MLLoadingView
    
    init(text: String = "") {
        loadingView = text == "" ? MLLoadingView() : MLLoadingView(text: text)

        super.init(nibName: nil, bundle: nil)
        view.addSubview(loadingView)
        loadingView.center = view.center
        modalPresentationStyle = .overCurrentContext
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
        self.view.backgroundColor = backgroundColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func animationController(forPresented presented: UIViewController,
                                      presenting: UIViewController,
                                      source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let transition = MLLoadingViewTransition()
        return transition
    }
    
    internal func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = MLLoadingViewTransition()
        transition.presenting = false
        return transition
    }
}

class MLLoadingViewTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let AnimateDuration = 0.25
    var presenting = true
    
    internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return AnimateDuration
    }
    
    internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        let animateScaleTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        let animateScaleNormal = CGAffineTransform(scaleX: 1.0, y: 1.0)
        
        if (presenting) {
            transitionContext.containerView.addSubview(toView!)
            
            toView?.alpha = 0
            toView?.transform = animateScaleTransform
            UIView.animate(withDuration: AnimateDuration, animations: {
                toView?.transform = animateScaleNormal
                toView?.alpha = 1.0
            }, completion: { finished in
                transitionContext.completeTransition(true)
            })
        } else {
            fromView?.alpha = 1.0
            UIView.animate(withDuration: AnimateDuration, animations: {
                fromView?.alpha = 0.0
            }, completion: { finished in
                transitionContext.completeTransition(true)
            })
        }
    }
}
