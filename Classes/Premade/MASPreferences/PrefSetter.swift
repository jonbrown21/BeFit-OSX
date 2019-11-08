//
//  PrefSetter.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/8/19.
//

import Foundation
import Cocoa

class PrefSetter: NSObject, NSApplicationDelegate {
    @IBOutlet var prefslider: NSSlider!
    @IBOutlet var sliderValueLabel: NSTextField!
    
    var textValue: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prefslider.target = self // assume the handler is [self sliderDidMove:]
        prefslider.action = #selector(sliderDidMove)

        let slidervalueFormatter = NumberFormatter()
        slidervalueFormatter.format = "#,###;0;(#,##0)"
        sliderValueLabel.cell?.formatter = slidervalueFormatter
        
        let goalPrefs = UserDefaults.standard.string(forKey: "goal-name")
        
        // Read default prefrences for member name
        if goalPrefs?.isEmpty ?? true {
            prefslider.stringValue = "2000"
            sliderValueLabel.stringValue = "2000"
        } else {
            prefslider.stringValue = goalPrefs ?? ""
            sliderValueLabel.stringValue = goalPrefs ?? ""
        }
    }
    
    @objc private func sliderDidMove(_ sender: NSSlider) {
        let textValue = sender.doubleValue
        sliderValueLabel.doubleValue = textValue
        
        let sliderPreferenceValue = prefslider.stringValue
        
        if sender == prefslider {
            UserDefaults.standard.set(sliderPreferenceValue, forKey: "goal-name")
        }
    }
}
