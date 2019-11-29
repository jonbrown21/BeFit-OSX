//
//  RightGraphView.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import WebKit

class RightGraphView: WebView {
    @IBOutlet var FoodListArrayController: NSArrayController!
    
    @IBOutlet var textField: NSTextField?
    @IBOutlet var textField2: NSTextField?
    @IBOutlet var textField3: NSTextField?
    @IBOutlet var textField4: NSTextField?
    @IBOutlet var textField5: NSTextField?
    @IBOutlet var textField6: NSTextField?
    @IBOutlet var textField7: NSTextField?
    @IBOutlet var textField8: NSTextField?
    @IBOutlet var textField9: NSTextField?
    @IBOutlet var textField10: NSTextField?
    @IBOutlet var textField11: NSTextField?
    @IBOutlet var textField12: NSTextField?
    @IBOutlet var textField13: NSTextField?
    @IBOutlet var textField14: NSTextField?
    @IBOutlet var textField15: NSTextField?
    @IBOutlet var textField16: NSTextField?
    @IBOutlet var textField17: NSTextField?
    @IBOutlet var textField18: NSTextField?
    @IBOutlet var textField19: NSTextField?
    @IBOutlet var textField20: NSTextField?
    @IBOutlet var textField21: NSTextField?
    @IBOutlet var textField22: NSTextField?
    @IBOutlet var textField23: NSTextField?
    @IBOutlet var textField24: NSTextField?
    @IBOutlet var textField25: NSTextField?
    @IBOutlet var textField26: NSTextField?
    @IBOutlet var CalFromFat: NSTextField?
    @IBOutlet var CarbsPerc: NSTextField?
    @IBOutlet var BadgeCount: NSTextField?
    
    deinit {
        FoodListArrayController.removeObserver(self, forKeyPath: "selection")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        FoodListArrayController.addObserver(self, forKeyPath: "selection", options: .new, context: nil)
    }
    
    private func drawGraphFromFood() {
        let item1 = textField?.stringValue ?? "" // Name of Food
        let item2 = textField2?.stringValue ?? "" // Calories
        let item3 = textField3?.stringValue ?? "" // Total Fat
        let item4 = textField4?.stringValue ?? "" // Saturated Fat
        let item5 = textField5?.stringValue ?? "" // Cholesterol
        let item6 = textField6?.stringValue ?? "" // Sodium
        let item7 = textField7?.stringValue ?? "" // Dietary Fiber
        let item8 = textField8?.stringValue ?? "" // Sugars
        let item9 = textField9?.stringValue ?? "" // Protein
        let item10 = textField10?.stringValue ?? "" // Carbs
        let item11 = textField11?.stringValue ?? "" // Vitamin C
        let item12 = textField12?.stringValue ?? "" // Iron %
        let item13 = textField13?.stringValue ?? "" // Calcium %
        let item14 = textField14?.stringValue ?? "" // Protein %
        let item15 = textField15?.stringValue ?? "" // Vitamin E
        let item16 = textField16?.stringValue ?? "" // Monounsaturated Fat
        let item17 = textField17?.stringValue ?? "" // Polyunsaturated Fat
        let item18 = textField18?.stringValue ?? "" // Fat from Cals
        let item19 = textField19?.stringValue ?? "" // Iron
        let item20 = textField20?.stringValue ?? "" // Calcium
        //let item21 = textField21?.stringValue ?? "0" // Protein
        let item22 = textField22?.stringValue ?? "" // Vitamin A
        let item23 = textField23?.stringValue ?? "" // Cal %
        //let item24 = textField24?.stringValue ?? "0" // Trans Fat
        let item25 = textField25?.stringValue ?? "" // Rating
        let item26 = textField26?.stringValue ?? "" // PintCats
        
        //let calfromfat = CalFromFat?.stringValue ?? ""
        let carbsperc = CarbsPerc?.stringValue ?? "0"
        
        //        if ([item24 doubleValue] < 0) {
        //            item24 = @"1";
        //        } else if ([item24 doubleValue] == 0) {
        //            item24 = @"1";
        //        }
        
        //pass that to webview with javascript
        let javascriptString = String(format: "graphFunction('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item16, item17, item18, item19, item20, item11, item22, item15)
            
        let javascriptStringCal = String(format: "graphFunctionDCal('%@', '%@', '%@','%@','%@')", item2, item3, item4, item5, item23)
            
        let javascriptStringCalPrint = String(format: "graphFunctionDCalPrint('%@', '%@', '%@','%@','%@')", item2, item3, item4, item5, item23)
            
        let javascriptStringCarb = String(format: "graphFunctionDCarb('%@', '%@', '%@','%@','%@')", item6, item7, item10, item8, carbsperc)
            
        let javascriptStringVit = String(format: "graphFunctionDVit('%@', '%@', '%@','%@','%@')", item11, item9, item12, item13, item14)
        
        let javascriptStringFull = String(format: "updateGage(%@)", item25)
        let javascriptStringFullTxt = String(format: "changeTxt('%@')", item26)
        
        //print(javascriptStringFull)
        
        stringByEvaluatingJavaScript(from: javascriptString)
        stringByEvaluatingJavaScript(from: javascriptStringFull)
        stringByEvaluatingJavaScript(from: javascriptStringFullTxt)
        stringByEvaluatingJavaScript(from: javascriptStringCal)
        stringByEvaluatingJavaScript(from: javascriptStringCalPrint)
        stringByEvaluatingJavaScript(from: javascriptStringCarb)
        stringByEvaluatingJavaScript(from: javascriptStringVit)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        drawGraphFromFood()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "selection" {
            needsDisplay = true
        }
    }
}
