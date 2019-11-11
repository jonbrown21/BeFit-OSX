//
//  NSShadow+MCAdditions.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/11/19.
//

import Foundation
import Cocoa

extension NSShadow {
    convenience init(color: NSColor, offset: NSSize, blurRadius: CGFloat) {
        self.init()
        self.shadowColor = color
        self.shadowOffset = offset
        self.shadowBlurRadius = blurRadius
    }
}
