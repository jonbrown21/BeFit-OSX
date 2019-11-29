//
//  AdvancedPreferencesViewController.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/8/19.
//

import Foundation
import Cocoa
import MASPreferences

class AdvancedPreferencesViewController: NSViewController, MASPreferencesViewController {
    @IBOutlet var regName: NSTextField!
    @IBOutlet var InstallButton: NSButton!
    
    init() {
        super.init(nibName: "AdvancedPreferencesView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - MASPreferencesViewController
    
    var viewIdentifier: String {
        return "AdvancedPreferences"
    }
    
    var toolbarItemImage: NSImage? {
        return NSImage(named: "Sped")
    }
    
    var toolbarItemLabel: String? {
        return NSLocalizedString("Widget", comment: "Toolbar item name for the Widget preference pane")
    }
    
    //MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let regpref = UserDefaults.standard.string(forKey: "reg-code")
        
        if regpref?.isEmpty ?? true {
            regName.stringValue = ""
        } else {
            regName.stringValue = regpref ?? ""
            InstallButton.title = "Widgets Already Installed"
            InstallButton.isEnabled = false
        }
    }
}
