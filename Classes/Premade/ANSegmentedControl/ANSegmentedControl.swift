//
//  ANSegmentedControl.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/11/19.
//

import Foundation
import Cocoa

class ANSegmentedControl: NSSegmentedControl, ANKnobAnimationDelegate {
    private var location: NSPoint = .zero
    
    let fastAnimationDuration: TimeInterval = 0.2
    let slowAnimationDuration: TimeInterval = 0.35
    
    override var selectedSegment: Int {
        get { return super.selectedSegment }
        set { setSelectedSegment(newValue, animate: true) }
    }
    
    override class var cellClass: AnyClass? {
        get { return ANSegmentedCell.self }
        set { }
    }
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        guard let unarchiver = coder as? NSKeyedUnarchiver else {
            super.init(coder: coder)
            return
        }
        
        let oldClass = NSSegmentedControl.cellClass!
        let newClass = Self.cellClass
        let oldClassName = NSStringFromClass(oldClass)
        unarchiver.setClass(newClass, forClassName: oldClassName)
        
        super.init(coder: coder)
        
        unarchiver.setClass(oldClass, forClassName: oldClassName)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setBoundsSize(NSSize(width: bounds.size.width, height: 25))
        setFrameSize(NSSize(width: frame.size.width, height: 25))
        
        location.x = frame.size.width / CGFloat(segmentCount) * CGFloat(selectedSegment)
        (cell as? NSSegmentedCell)?.trackingMode = .selectOne
    }
    
    func drawCenteredImage(_ image: NSImage, inFrame frame: NSRect, imageFraction: CGFloat) {
        let imageSize = image.size
        let rect = NSRect(
            x: frame.origin.x + (frame.size.width - imageSize.width) / 2,
            y: frame.origin.y + (frame.size.height - imageSize.height) / 2,
            width: imageSize.width,
            height: imageSize.height)
        
        image.draw(in: rect, from: .zero, operation: .sourceOver, fraction: imageFraction, respectFlipped: true, hints: nil)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        var rect = self.bounds
        rect.size.height -= 1
        drawBackgroud(rect)
        drawKnob(rect)
    }
    
    func drawSegment(_ segment: Int, inFrame frame: NSRect, withView controlView: NSView) {
        let imageFraction: CGFloat
        
        if window?.isKeyWindow ?? false {
            imageFraction = 0.5
        } else {
            imageFraction = 2
        }
        
        if let img = image(forSegment: segment) {
            NSGraphicsContext.current?.imageInterpolation = .high
            drawCenteredImage(img, inFrame: frame, imageFraction: imageFraction)
        }
    }
    
    func drawBackgroud(_ rect: NSRect) {
        guard let ctx = NSGraphicsContext.current else {
            return
        }
        
        let radius: CGFloat = 3.5
        let gradient: NSGradient?
        let frameColor: NSColor
        let path = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
        
        if window?.isKeyWindow ?? false {
            gradient = NSGradient(starting: NSColor(calibratedWhite: 1, alpha: 1), ending: NSColor(calibratedWhite: 1, alpha: 1))
            frameColor = NSColor(calibratedWhite: 0.5, alpha: 1)
        } else {
            gradient = NSGradient(starting: NSColor(calibratedWhite: 1, alpha: 1), ending: NSColor(calibratedWhite: 1, alpha: 1))
            frameColor = NSColor(calibratedWhite: 0.5, alpha: 1)
        }
        
        // シャドウ
        ctx.saveGraphicsState()
        let dropShadow = NSShadow()
        dropShadow.shadowOffset = NSSize(width: 0, height: -1)
        dropShadow.shadowBlurRadius = 1
        dropShadow.shadowColor = NSColor(calibratedWhite: 0.901, alpha: 0.75)
        dropShadow.set()
        path.fill()
        ctx.restoreGraphicsState()
        
        // 塗り
        gradient?.draw(in: path, angle: -90)
        
        // 枠線
        frameColor.setStroke()
        path.strokeInside()
        
        let segmentWidth = rect.size.width / CGFloat(segmentCount)
        let segmentHeight = rect.size.height
        var segmentRect = NSRect(x: 0, y: 0, width: segmentWidth, height: segmentHeight)
        
        for s in 0 ..< segmentCount {
            drawSegment(s, inFrame: segmentRect, withView: self)
            segmentRect.origin.x += segmentWidth
        }
    }
    
    func drawKnob(_ rect: NSRect) {
        let radius: CGFloat = 3
        let gradient: NSGradient?
        let frameColor: NSColor
        let imageFraction: CGFloat
        
        if window?.isKeyWindow ?? false {
            gradient = NSGradient(starting: NSColor(calibratedWhite: 0.95, alpha: 1), ending: NSColor(calibratedWhite: 1, alpha: 1))
            frameColor = NSColor(calibratedWhite: 0.5, alpha: 1)
            imageFraction = 1
        } else {
            gradient = NSGradient(starting: NSColor(calibratedWhite: 0.95, alpha: 1), ending: NSColor(calibratedWhite: 1, alpha: 1))
            frameColor = NSColor(calibratedWhite: 0.5, alpha: 1)
            imageFraction = 0.25
        }
        
        let width = rect.size.width / CGFloat(segmentCount)
        let height = rect.size.height
        let knobRect = NSRect(x: location.x, y: rect.origin.y, width: width, height: height)
        let path = NSBezierPath(roundedRect: knobRect, xRadius: radius, yRadius: radius)
        
        // 塗り
        gradient?.draw(in: path, angle: -90)
        // 枠線
        frameColor.setStroke()
        path.strokeInside()
        
        let newSegment = Int(round(location.x / width))
        if let img = image(forSegment: newSegment) {
            drawCenteredImage(img, inFrame: knobRect, imageFraction: imageFraction)
        }
    }
    
    func animateTo(_ x: Int) {
        let maxX = frame.size.width - frame.size.width / CGFloat(segmentCount)
        let duration: TimeInterval
        let curve: NSAnimation.Curve
        
        if location.x == 0 || location.x == maxX {
            duration = fastAnimationDuration
            curve = .easeInOut
        } else {
            duration = slowAnimationDuration * Double(abs(location.x - CGFloat(x)) / maxX)
            curve = .linear
        }
        
        let a = ANKnobAnimation(start: Int(location.x), end: x, duration: duration, curve: curve)
        
        a.knobAnimationDelegate = self
        a.start()
    }
    
    func setPosition(_ pos: Int) {
        location.x = CGFloat(pos)
        display()
    }
    
    func setSelectedSegment(_ newSegment: Int, animate: Bool) {
        if newSegment == super.selectedSegment {
            return
        }
        
        let maxX = frame.size.width - frame.size.width / CGFloat(segmentCount)
        
        let x = newSegment > segmentCount ? maxX : CGFloat(newSegment) * frame.size.width / CGFloat(segmentCount)
        
        if animate {
            animateTo(Int(x))
        } else {
            needsDisplay = true
        }
        
        super.selectedSegment = newSegment
    }
    
    func offsetLocationByX(_ x: CGFloat) {
        location.x += x
        let maxX = frame.size.width - frame.size.width / CGFloat(segmentCount)
        
        if location.x < 0 {
            location.x = 0
        }
        
        if location.x > maxX {
            location.x = maxX
        }
        
        needsDisplay = true
    }
    
    override func mouseDown(with event: NSEvent) {
        var loop = true
        
        let clickLocation = convert(event.locationInWindow, from: nil)
        let knobWidth = frame.size.width / CGFloat(segmentCount)
        let knobRect = NSRect(x: location.x, y: 0, width: knobWidth, height: frame.size.height)
        
        if bounds.contains(clickLocation) {
            var localLastDragLocation: NSPoint = clickLocation
            
            while loop {
                guard let localEvent = window?.nextEvent(matching: [.leftMouseUp, .leftMouseDragged]) else {
                    break
                }
                
                switch localEvent.type {
                case .leftMouseDragged:
                    if knobRect.contains(clickLocation) {
                        let newDragLocation = convert(localEvent.locationInWindow, from: nil)
                        offsetLocationByX(newDragLocation.x - localLastDragLocation.x)
                        localLastDragLocation = newDragLocation
                        autoscroll(with: localEvent)
                    }
                    
                case .leftMouseUp:
                    loop = false
                    let newSegment: Int
                    
                    if localLastDragLocation == clickLocation {
                        newSegment = Int(floor(clickLocation.x / knobWidth))
                    } else {
                        newSegment = Int(round(location.x / knobWidth))
                    }
                    
                    animateTo(newSegment * Int(knobWidth))
                    selectedSegment = newSegment
                    window?.invalidateCursorRects(for: self)
                    sendAction(self.action, to: self.target)
                    
                default:
                    break
                }
            }
        }
    }
}
