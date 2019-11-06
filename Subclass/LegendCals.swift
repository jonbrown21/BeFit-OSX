//
//  LegendCals.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import Cocoa

class LegendCals: NSView {
    override func draw(_ dirtyRect: NSRect) {
        // Get the graphics context that we are currently executing under
        guard let gc = NSGraphicsContext.current else {
            return
        }
        
        // Save the current graphics context settings
        gc.saveGraphicsState()
        
        // Set the color in the current graphics context for future draw operations
        let calColor = NSColor(calibratedRed: 0.38, green: 0.48, blue: 0.52, alpha: 1)
        
        calColor.setStroke()
        calColor.setFill()
        
        // Create our circle path
        let rect = NSRect(x: 5, y: 5, width: 5, height: 5)
        let circlePath = NSBezierPath()
        circlePath.appendOval(in: rect)
        
        // Outline and fill the path
        circlePath.stroke()
        circlePath.fill()
        
        // Restore the context to what it was before we messed with it
        gc.restoreGraphicsState()
    }
}
