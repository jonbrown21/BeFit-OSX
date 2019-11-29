//
//  CustomLevelIndicatorCell.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import Cocoa

class CustomLevelIndicatorCell: NSLevelIndicatorCell {
    private let greenColor = NSColor(calibratedRed: 0.152, green: 0.682, blue: 0.37, alpha: 1)
    private let yellowColor = NSColor(calibratedRed: 0.411, green: 0.643, blue: 0.796, alpha: 1)
    private let redColor = NSColor(calibratedRed: 0.752, green: 0.233, blue: 0.164, alpha: 1)
    
    override func draw(withFrame cellFrame: NSRect, in controlView: NSView) {
        var level = (self.doubleValue - self.minValue) / (self.maxValue - self.minValue)
        if level > 1.0 {
            level = 1.0
        }
        //print("Level: \(level)")
        
        let fillColor: NSColor
        
        if self.doubleValue > self.criticalValue {
            fillColor = redColor
        } else if self.doubleValue > self.warningValue {
            fillColor = yellowColor
        } else {
            fillColor = greenColor
        }
        
        //NSLog(@"Level: %a", self.criticalValue);
        
        var levelRect = NSInsetRect(cellFrame, 2, 1)
        levelRect.size.width = levelRect.size.width * CGFloat(level)
        let levelPath = NSBezierPath(roundedRect: levelRect, xRadius: 3, yRadius: 3)
        fillColor.setFill()
        levelPath.fill()
        
        let indicatorPath = NSBezierPath(roundedRect: NSInsetRect(cellFrame, 2, 1), xRadius: 3, yRadius: 3)
        indicatorPath.lineWidth = 0.15
        NSColor.gray.setStroke()
        indicatorPath.stroke()
    }
}
