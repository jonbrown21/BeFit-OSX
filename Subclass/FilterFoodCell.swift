//
//  FilterFoodCell.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import Cocoa

class FilterFoodCell: NSSearchFieldCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        drawsBackground = false
    }
}
