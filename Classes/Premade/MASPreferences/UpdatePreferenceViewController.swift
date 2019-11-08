//
//  UpdatePreferenceViewController.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/8/19.
//

import Foundation
import Cocoa
import MASPreferences

class UpdatePreferenceViewController: NSViewController, MASPreferencesViewController {
    @IBOutlet var button: NSButton!
    
    init() {
        super.init(nibName: "UpdatePreferencesView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - MASPreferencesViewController
    
    var viewIdentifier: String {
        return "UpdatePreferences"
    }
    
    var toolbarItemLabel: String? {
        return NSLocalizedString("Update", comment: "Toolbar item name for the Update preference pane")
    }
    
    var toolbarItemImage: NSImage? {
        return NSImage(named: "Update")
    }
    
    //MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let color = NSColor.red
        let colorTitle = NSMutableAttributedString(attributedString: button.attributedTitle)
        let titleRange = NSRange(location: 0, length: colorTitle.length)
        
        colorTitle.addAttribute(.foregroundColor, value: color, range: titleRange)
        
        button.attributedTitle = colorTitle
    }
}
