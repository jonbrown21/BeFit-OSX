//
//  MCViewFlipController.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/11/19.
//

import Foundation
import Cocoa

class MCViewFlipController: NSObject, CAAnimationDelegate {
    private let duration: TimeInterval = 0.75
    private let hostView: NSView
    private let frontView: NSView
    private let backView: NSView
    private var bottomView: NSView?
    private var topLayer: CALayer?
    private var bottomLayer: CALayer?
    private var isFlipped: Bool = false
    
    var visibleView: NSView {
        return isFlipped ? backView : frontView
    }
    
    init(hostView: NSView, frontView: NSView, backView: NSView) {
        self.hostView = hostView
        self.frontView = frontView
        self.backView = backView
        
        super.init()
    }
    
    @IBAction func flip(_ sender: AnyObject) {
        let topView: NSView
        let bottomView: NSView
        
        if isFlipped {
            topView = backView
            bottomView = frontView
        } else {
            topView = frontView
            bottomView = backView
        }
        
        bottomView.frame = topView.frame
        
        guard let topLayer = topView.layerFromContents,
            let bottomLayer = bottomView.layerFromContents else {
                assertionFailure()
                return
        }
        
        let topAnimation = CAAnimation.flipAnimationWithDuration(duration, forLayerBeginningOnTop: true, scaleFactor: 1.3)
        let bottomAnimation = CAAnimation.flipAnimationWithDuration(duration, forLayerBeginningOnTop: false, scaleFactor: 1.3)
        
        let zDistance: CGFloat = 1500
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / zDistance
        topLayer.transform = perspective
        bottomLayer.transform = perspective
        
        bottomLayer.frame = topView.frame
        bottomLayer.isDoubleSided = false
        hostView.layer?.addSublayer(bottomLayer)
        
        topLayer.isDoubleSided = false
        topLayer.frame = topView.frame
        hostView.layer?.addSublayer(topLayer)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        topView.removeFromSuperview()
        CATransaction.commit()
        
        topAnimation.delegate = self
        CATransaction.begin()
        topLayer.add(topAnimation, forKey: "flip")
        bottomLayer.add(bottomAnimation, forKey: "flip")
        CATransaction.commit()
        
        self.bottomView = bottomView
        self.topLayer = topLayer
        self.bottomLayer = bottomLayer
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let flipin = UserDefaults.standard.bool(forKey: "flipPref")
        isFlipped = !isFlipped
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        bottomView.flatMap { hostView.addSubview($0) }
        topLayer?.removeFromSuperlayer()
        bottomLayer?.removeFromSuperlayer()
        topLayer = nil
        bottomLayer = nil
        CATransaction.commit()
        
        UserDefaults.standard.set(isFlipped, forKey: "flipPref")
        
        print("Flip Status: \(isFlipped)")
        print("Flip Preference: \(flipin)")
    }
}

private extension CAAnimation {
    static func flipAnimationWithDuration(_ aDuration: TimeInterval, forLayerBeginningOnTop beginsOnTop: Bool, scaleFactor: CGFloat) -> CAAnimation {
        // Rotating halfway (pi radians) around the Y axis gives the appearance of flipping
        let flipAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        let startValue = beginsOnTop ? 0.0 : CGFloat.pi
        let endValue = beginsOnTop ? -CGFloat.pi : 0.0
        flipAnimation.fromValue = startValue
        flipAnimation.toValue = endValue
        
        // Shrinking the view makes it seem to move away from us, for a more natural effect
        // Can also grow the view to make it move out of the screen
        var animations: [CABasicAnimation] = [flipAnimation]
        
        if scaleFactor != 1.0 {
            let shrinkAnimation = CABasicAnimation(keyPath: "transform.scale")
            shrinkAnimation.toValue = scaleFactor
            
            // We only have to animate the shrink in one direction, then use autoreverse to "grow"
            shrinkAnimation.duration = aDuration * 0.5
            shrinkAnimation.autoreverses = true
            
            animations.append(shrinkAnimation)
        }
        
        // Combine the flipping and shrinking into one smooth animation
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = animations
        
        // As the edge gets closer to us, it appears to move faster. Simulate this in 2D with an easing function
        animationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animationGroup.duration = aDuration
        
        // Hold the view in the state reached by the animation until we can fix it, or else we get an annoying flicker
        animationGroup.fillMode = CAMediaTimingFillMode.forwards
        animationGroup.isRemovedOnCompletion = false
        
        return animationGroup
    }
}

private extension NSView {
    var layerFromContents: CALayer? {
        guard let bitmapRep = bitmapImageRepForCachingDisplay(in: bounds) else {
            return nil
        }
        
        let newLayer = CALayer()
        newLayer.bounds = bounds
        cacheDisplay(in: bounds, to: bitmapRep)
        newLayer.contents = bitmapRep.cgImage
        
        return newLayer
    }
}
