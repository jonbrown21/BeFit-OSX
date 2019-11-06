//
//  ColumnControllerPopUpButton.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import Cocoa

class ColumnControllerPopUpButton: NSPopUpButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Total Fat item has its tag set as 99
        selectItem(withTag: 49)
    }
}
