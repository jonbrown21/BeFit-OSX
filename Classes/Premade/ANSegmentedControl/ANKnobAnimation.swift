//
//  ANKnobAnimation.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/11/19.
//

import Foundation
import Cocoa

protocol ANKnobAnimationDelegate: class {
    func setPosition(_ pos: Int)
}

class ANKnobAnimation: NSAnimation {
    let start: Int
    let range: Int
    weak var knobAnimationDelegate: ANKnobAnimationDelegate?
    
    init(start begin: Int, end: Int, duration: TimeInterval, curve: NSAnimation.Curve) {
        self.start = begin
        self.range = end - begin
        
        super.init(duration: duration, animationCurve: curve)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var currentProgress: NSAnimation.Progress {
        didSet {
            let x = start + Int(currentProgress * Float(range))
            knobAnimationDelegate?.setPosition(x)
        }
    }
}
