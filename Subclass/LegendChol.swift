//
//  LegendChol.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import Cocoa

class LegendChol: NSView {
    override func draw(_ dirtyRect: NSRect) {
        // Get the graphics context that we are currently executing under
        guard let gc = NSGraphicsContext.current else {
            return
        }
        
        // Save the current graphics context settings
        gc.saveGraphicsState()
        
        // Set the color in the current graphics context for future draw operations
        let color = NSColor(calibratedRed: 0.77, green: 0.18, blue: 0.16, alpha: 1)
        
        color.setStroke()
        color.setFill()
        
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
