//
//  SideFooter.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import Cocoa

class SideFooter: NSView {
    override func draw(_ dirtyRect: NSRect) {
        //    NSColor *backColor = [NSColor colorWithCalibratedRed:0.80 green:0.83 blue:0.86 alpha:1.0f];
        //
        //    [backColor setFill];
        //    NSRectFill(dirtyRect);
        //    [super drawRect:dirtyRect];
            
            
        let backgroundLayer = CALayer()
        backgroundLayer.backgroundColor = NSColor(red: 0.8, green: 0.83, blue: 0.86, alpha: 1).cgColor
            
        layer = backgroundLayer
        wantsLayer = true
    }
}
