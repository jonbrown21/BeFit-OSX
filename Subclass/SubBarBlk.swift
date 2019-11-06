//
//  SubBarBlk.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import Cocoa

class SubBarBlk: NSView {
    private var lineColor: NSColor = NSColor.black {
        didSet {
            needsDisplay = true
        }
    }
    
    private var clickCount: Int = 0
    
    override func mouseDown(with event: NSEvent) {
        clickCount = (clickCount + 1) % 7
        //let hue = CGFloat(clickCount) / 6
        //lineColor = NSColor(calibratedHue: hue, saturation: 1, brightness: 1, alpha: 1)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        let wholeRect = bounds
        //let myColor = NSColor(calibratedRed: 0.42, green: 0.42, blue: 0.42, alpha: 1)
        
        let line = NSBezierPath()
        line.move(to: NSPoint(x: 0, y: wholeRect.height))
        line.line(to: NSPoint(x: wholeRect.width, y: wholeRect.height))
        line.lineWidth = 1 // Make it easy to see
        lineColor.set()
        line.stroke()
    }
}
