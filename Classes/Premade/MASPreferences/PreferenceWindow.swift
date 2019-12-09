//
//  PreferenceWindow.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/8/19.
//

import Foundation
import Cocoa
import MASPreferences

class PreferenceWindow: NSObject {
    private lazy var preferencesWindowController: NSWindowController = {
        let generalViewController = GeneralPreferencesViewController()
        let updateViewController = UpdatePreferenceViewController()
        
        #if WEBSITE
        let controllers: [NSViewController] = [generalViewController, updateViewController]
        #else
        let controllers: [NSViewController] = [generalViewController]
        #endif
        
        let title = NSLocalizedString("Preferences", comment: "Common title for Preferences window")
        let vc = MASPreferencesWindowController(viewControllers: controllers, title: title)
        //vc.window?.backgroundColor = NSColor(patternImage: NSImage(named: "Black")!)
        return vc
    }()
    
    @IBAction func openPreferences(_ sender: AnyObject) {
        preferencesWindowController.showWindow(nil)
    }
}
