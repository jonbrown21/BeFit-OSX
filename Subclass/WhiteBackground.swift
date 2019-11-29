//
//  WhiteBackground.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import Cocoa

class WhiteBackground: NSView {
    override func draw(_ dirtyRect: NSRect) {
        let backColor = NSColor(calibratedRed: 1, green: 1, blue: 1, alpha: 1)
        backColor.setFill()
        dirtyRect.fill()
        super.draw(dirtyRect)
    }
}
