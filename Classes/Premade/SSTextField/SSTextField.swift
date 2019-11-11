//
//  SSTextField.swift
//  BeFit
//
//  Created by Dan Messing on 2/13/10.
//  Copyright 2010 Stunt Software. All rights reserved.
//

// Mimics the appearance of Safari 4's URL text field.

import Foundation
import Cocoa

// Our number field types
enum CINumberFieldType: String {
    case integer
    case double
    case money
}

class SSTextField: NSTextField {
    var type: CINumberFieldType?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        drawsBackground = false
        
        if cell?.controlSize == NSControl.ControlSize.mini {
            font = NSFont.systemFont(ofSize: 8)
        } else if cell?.controlSize == NSControl.ControlSize.small {
            font = NSFont.systemFont(ofSize: 9.4)
        } else {
            font = NSFont.systemFont(ofSize: 11.88)
        }
    }
    
    override func textDidEndEditing(_ notification: Notification) {
        if let type = type {
            switch type {
            case .integer:
                intValue = intValue
                
            case .double:
                doubleValue = doubleValue
                
            case .money:
                let float = Float(stringValue.replacingOccurrences(of: "$", with: "")) ?? 0
                stringValue = String(format: "$%.02f", float)
            }
        }
        
        super.textDidEndEditing(notification)
    }
    
    override func setValue(_ value: Any?, forKeyPath keyPath: String) {
        if keyPath == "type" {
            if let newType = (value as? String).flatMap({ CINumberFieldType(rawValue: $0) }) {
                type = newType
            }
        } else {
            setValue(value, forUndefinedKey: keyPath)
        }
    }
}
