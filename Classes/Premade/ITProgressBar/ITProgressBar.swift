//
//  ITProgressBar.swift
//  BeFit
//
//  Created by Ilija Tovilo on 25/10/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

import Foundation
import Cocoa

private let kStripesAnimationKey = "x"
private let kOpacityAnimationKey = "opacity"
private let kStripesOpacity: Float = 0.04
private let kColorTintLayerOpacity: Float = 0.2

/**
*  ITProgressBar is a simple progress bar control.
*  It's implemented using Core Animation, which makes it incredibly performant.
*/
class ITProgressBar: NSView, CAAnimationDelegate {
    //MARK: - Public Properties
    
    /**
    *  Indicates the progress of the operation
    */
    var floatValue: CGFloat {
        get { return _floatValue }
        set {
            if newValue < 0 || newValue > 1 {
                print("Invalid value set for 'floatValue'. Value must be between 0.0 and 1.0")
            }
            
            _floatValue = min(max(newValue, 0), 1)
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            resizeInnerLayers()
            CATransaction.commit()
        }
    }
    
    /**
    *  Sets the color tint
    */
    var colorTint: NSColor = .black {
        didSet {
            reloadColorTint()
        }
    }
    
    /**
    *  Indicates if the stripes on the progress bar animate.
    *  If this is set to `NO`, the stripes layer will automatically hide.
    */
    var animates: Bool = false {
        didSet {
            if animates != oldValue {
                if animates {
                    CATransaction.begin()
                    if stripesLayer.animation(forKey: kStripesAnimationKey) == nil && animates && !it_isHidden {
                        stripesLayer.add(stripesAnimation(), forKey: kStripesAnimationKey)
                    }
                    
                    stripesLayer.opacity = kStripesOpacity
                    CATransaction.commit()
                } else {
                    CATransaction.setCompletionBlock {
                        if self.stripesLayer.animation(forKey: kStripesAnimationKey) != nil && !self.animates {
                            self.stripesLayer.removeAnimation(forKey: kStripesAnimationKey)
                        }
                    }
                    
                    stripesLayer.opacity = 0
                }
            }
        }
    }
    
    /**
    *  The animation duration.
    *  Specifically, this is the diration by moving the tile image by it's width
    */
    var animationDuration: CGFloat = 0.3 {
        didSet {
            if animates {
                animates = false
                stripesLayer.removeAnimation(forKey: kStripesAnimationKey)
                animates = true
            }
        }
    }
    
    /**
    *  Sets the width of the border.
    */
    var borderWidth: CGFloat = 1 {
        didSet {
            if shadowWidth > borderWidth {
                shadowWidth = borderWidth
            }
            
            updateLayer()
        }
    }
    
    /**
    *  Sets the width of the shadow.
    */
    var shadowWidth: CGFloat {
        get { return _shadowWidth }
        set {
            if newValue > borderWidth {
                print("Warning: Line width must be at least as large as shadow width")
                return
            }
            
            _shadowWidth = newValue
            updateLayer()
        }
    }
    
    /**
    *  The image that is used on the stripes layer.
    *  You can use whatever image you want, just make sure it's tilable.
    */
    var stripesImage: NSImage = ITProgressBar.stripesImageWith(size: NSSize(width: 30, height: 20)) {
        didSet {
            updateLayer()
        }
    }
    
    private var it_isHidden: Bool = false {
        didSet {
            if isHidden != it_isHidden {
                if it_isHidden {
                    NSAnimationContext.beginGrouping()
                    NSAnimationContext.current.completionHandler = {
                        if self.it_isHidden {
                            super.isHidden = true
                        }
                        
                        self.stripesLayer.removeAnimation(forKey: kStripesAnimationKey)
                    }
                    animator().alphaValue = 0
                    NSAnimationContext.endGrouping()
                } else {
                    NSAnimationContext.beginGrouping()
                    super.isHidden = false
                    animator().alphaValue = 1
                    if animates {
                        stripesLayer.add(stripesAnimation(), forKey: kStripesAnimationKey)
                    }
                    NSAnimationContext.endGrouping()
                }
            }
        }
    }
    
    //MARK: - Private Properties
    
    private var _floatValue: CGFloat = 1
    private var _shadowWidth: CGFloat = 1
    private let stripesLayer = CALayer()
    private let borderLayer = CALayer()
    private let fillLayer = CAGradientLayer()
    private let backgroundLayer = CAGradientLayer()
    private let clipLayer = CALayer()
    private let innerClipLayer = CALayer()
    private let innerShadowLayer = CALayer()
    private let colorTintLayer = CALayer()
    
    //MARK: - Init
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        // Enable Core Animation
        wantsLayer = true
        
        // Init layers
        stripesLayer.anchorPoint = NSPoint(x: 0, y: 0.5)
        stripesLayer.opacity = kStripesOpacity
        colorTintLayer.opacity = kColorTintLayerOpacity
        clipLayer.masksToBounds = true
        innerClipLayer.masksToBounds = true
        
        backgroundLayer.colors = [
            NSColor(deviceWhite: 0.55, alpha: 1).cgColor,
            NSColor(deviceWhite: 0.4, alpha: 1).cgColor
        ]
        
        fillLayer.colors = [
            NSColor(deviceWhite: 0.75, alpha: 1).cgColor,
            NSColor(deviceWhite: 1, alpha: 1).cgColor
        ]
        
        innerClipLayer.addSublayer(fillLayer)
        innerClipLayer.addSublayer(stripesLayer)
        innerClipLayer.addSublayer(innerShadowLayer)
        innerClipLayer.addSublayer(colorTintLayer)
        
        clipLayer.addSublayer(backgroundLayer)
        clipLayer.addSublayer(borderLayer)
        clipLayer.addSublayer(innerClipLayer)
        
        layer!.addSublayer(clipLayer)
        
        // Force update
        resizeLayers()
        
        // Start animation
        animates = true
    }
    
    //MARK: - Update Layers
    
    override func viewDidMoveToWindow() {
        NotificationCenter.default.addObserver(self, selector: #selector(viewResized), name: NSView.frameDidChangeNotification, object: self)
    }
    
    @objc private func viewResized() {
        resizeLayers()
    }
    
    private func resizeLayers() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        // Clip Layer
        clipLayer.frame = bounds
        clipLayer.cornerRadius = clipLayer.frame.size.height / 2
        resizeInnerLayers()
        
        // Setting frames
        fillLayer.frame = bounds
        borderLayer.frame = bounds
        colorTintLayer.frame = bounds
        backgroundLayer.frame = bounds
        
        // Updating Content
        borderLayer.contents = borderImageFor(size: bounds.size, withInnerShadow: false)
        stripesLayer.backgroundColor = NSColor(patternImage: stripesImage).cgColor
        var stripeFrame = bounds
        stripeFrame.origin.x = -stripesImage.size.width
        stripeFrame.size.width = (ceil(bounds.size.width / stripesImage.size.width) + 1) * stripesImage.size.width
        stripesLayer.frame = stripeFrame
        
        CATransaction.commit()
    }
    
    private func reloadColorTint() {
        colorTintLayer.backgroundColor = colorTint.cgColor
    }
    
    private func resizeInnerLayers() {
        innerClipLayer.frame = bounds.insetBy(dx: borderWidth, dy: borderWidth)
        innerClipLayer.frame = NSRect(
            origin: innerClipLayer.frame.origin,
            size: CGSize(width: innerClipLayer.frame.width * floatValue, height: innerClipLayer.frame.height)
        )
        
        innerClipLayer.cornerRadius = innerClipLayer.frame.height / 2
        innerShadowLayer.frame = innerClipLayer.bounds.insetBy(dx: -borderWidth, dy: -borderWidth)
        innerShadowLayer.cornerRadius = innerShadowLayer.frame.height / 2
        innerShadowLayer.contents = borderImageFor(size: innerShadowLayer.frame.size, withInnerShadow: true)
    }
    
    //MARK: - NSAnimatablePropertyContainer
    
    override class func defaultAnimation(forKey key: NSAnimatablePropertyKey) -> Any? {
        if key == "floatValue" {
            let anim = CABasicAnimation()
            anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            return anim
        } else {
            return super.defaultAnimation(forKey: key)
        }
    }
    
    //MARK: - Helpers
    
    private func stripesAnimation() -> CABasicAnimation {
        let moveAnim = CABasicAnimation(keyPath: "position.x")
        moveAnim.fromValue = -stripesImage.size.width
        moveAnim.byValue = stripesImage.size.width
        moveAnim.duration = TimeInterval(animationDuration)
        moveAnim.isRemovedOnCompletion = false
        moveAnim.delegate = self
        moveAnim.repeatCount = Float.greatestFiniteMagnitude
        moveAnim.autoreverses = false
        
        return moveAnim
    }
    
    //MARK: - Drawing
    
    private func borderImageFor(size: NSSize, withInnerShadow innerShadowFlag: Bool) -> NSImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        
        return NSImage(size: size, flipped: false) { dstRect in
            //// Color Declarations
            let borderColor = NSColor(calibratedRed: 0.291, green: 0.291, blue: 0.291, alpha: 1)
            let innerShadowColor = NSColor(calibratedRed: 1, green: 1, blue: 1, alpha: 1)
            
            //// Shadow Declarations
            let innerShadow = NSShadow()
            innerShadow.shadowColor = innerShadowColor.withAlphaComponent(0.6)
            innerShadow.shadowOffset = NSSize(width: 0, height: -self.shadowWidth)
            innerShadow.shadowBlurRadius = 0
            
            //// Frames
            let baseFrame = NSRect(origin: .zero, size: size)
            let radius = baseFrame.size.height / 2
            //// BorderPath Drawing
            let borderPathPath = NSBezierPath(
                roundedRect: NSRect(
                    x: baseFrame.minX + self.borderWidth / 2,
                    y: baseFrame.minY + self.borderWidth / 2,
                    width: baseFrame.width - self.borderWidth,
                    height: baseFrame.height - self.borderWidth
                ),
                xRadius: radius,
                yRadius: radius
            )
            
            NSGraphicsContext.saveGraphicsState()
            
            if innerShadowFlag {
                innerShadow.set()
            }
            
            borderColor.setStroke()
            borderPathPath.lineWidth = self.borderWidth
            borderPathPath.stroke()
            
            NSGraphicsContext.restoreGraphicsState()
            
            return true
        }
    }
    
    private static func stripesImageWith(size: NSSize) -> NSImage {
        return NSImage(size: size, flipped: true) { dstRect in
            //// Color Declarations
            let color = NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 1)
            
            //// Frames
            let frame = NSRect(origin: .zero, size: size)
            
            //// WhiteBackground Drawing
            let whiteBackgroundPath = NSBezierPath(rect: NSRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height))
            NSColor.white.setFill()
            whiteBackgroundPath.fill()
            
            //// Stripe2 Drawing
            let stripe2Path = NSBezierPath()
            stripe2Path.move(to: NSPoint(x: frame.maxX, y: frame.minY))
            stripe2Path.line(to: NSPoint(x: frame.maxX, y: frame.minY + 0.5 * frame.height))
            stripe2Path.line(to: NSPoint(x: frame.minX + 0.5 * frame.width, y: frame.maxY))
            stripe2Path.line(to: NSPoint(x: frame.minX, y: frame.maxY))
            stripe2Path.line(to: NSPoint(x: frame.maxX, y: frame.minY))
            stripe2Path.close()
            color.setFill()
            stripe2Path.fill()
            
            //// Stripe1 Drawing
            let stripe1Path = NSBezierPath()
            stripe1Path.move(to: NSPoint(x: frame.minX, y: frame.minY))
            stripe1Path.line(to: NSPoint(x: frame.minX + 0.5 * frame.width, y: frame.minY))
            stripe1Path.line(to: NSPoint(x: frame.minX, y: frame.minY + 0.5 * frame.height))
            stripe1Path.line(to: NSPoint(x: frame.minX, y: frame.minY))
            stripe1Path.close()
            NSColor.black.setFill()
            stripe1Path.fill()
            
            return true
        }
    }
}
