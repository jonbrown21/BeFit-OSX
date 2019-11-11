//
//  NSBezierPath+MCAdditions.swift
//  BeFit
//
//  Created by Sean Patrick O'Brien on 4/1/08.
//  Copyright 2008 MolokoCacao. All rights reserved.
//

import Foundation
import Cocoa

extension NSBezierPath {
    // Credit for the next two methods goes to Matt Gemmell
    func strokeInside() {
        strokeInsideWithin(rect: .zero)
    }
    
    func strokeInsideWithin(rect clipRect: NSRect) {
        guard let context = NSGraphicsContext.current else {
            return
        }
        
        /* Save the current graphics context. */
        context.saveGraphicsState()
        
        let originalLineWidth = lineWidth
        
        defer {
            /* Restore the previous graphics context when leaving this function. */
            context.restoreGraphicsState()
            lineWidth = originalLineWidth
        }
        
        /* Double the stroke width, since -stroke centers strokes on paths. */
        lineWidth = originalLineWidth * 2
        
        /* Clip drawing to this path; draw nothing outwith the path. */
        setClip()
        
        /* Further clip drawing to clipRect, usually the view's frame. */
        if clipRect.size.width > 0 && clipRect.size.height > 0 {
            NSBezierPath.clip(clipRect)
        }
        
        /* Stroke the path. */
        stroke()
    }
}
