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
        //let advancedViewController = AdvancedPreferencesViewController()
        
        #if TRIAL
        let controllers: [NSViewController] = [generalViewController, updateViewController]
        #elseif WEBSITE
        let controllers: [NSViewController] = [generalViewController, updateViewController]
        #elseif STORE
        let controllers: [NSViewController] = [generalViewController]
        #else
        let controllers: [NSViewController] = [generalViewController]
        #endif
        
        let title = NSLocalizedString("Preferences", comment: "Common title for Preferences window")
        return MASPreferencesWindowController(viewControllers: controllers, title: title)
    }()
    
    @IBAction func openPreferences(_ sender: AnyObject) {
        preferencesWindowController.window?.backgroundColor = NSColor(patternImage: NSImage(named: "Black")!)
        preferencesWindowController.showWindow(nil)
    }
}
