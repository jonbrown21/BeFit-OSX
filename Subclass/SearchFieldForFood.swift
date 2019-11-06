//
//  SearchFieldForFood.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import Cocoa

class SearchFieldForFood: NSSearchField {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cellMenu = NSMenu(title: "Search Menu")
        let item = NSMenuItem(title: "Recents", action: nil, keyEquivalent: "")

        item.tag = NSSearchField.recentsMenuItemTag
        cellMenu.insertItem(item, at: 0)
        
        (cell as? NSSearchFieldCell)?.searchMenuTemplate = cellMenu
    }
}
