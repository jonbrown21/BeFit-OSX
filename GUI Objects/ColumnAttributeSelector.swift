//
//  ColumnAttributeSelector.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/5/19.
//

import Foundation
import Cocoa

class ColumnAttributeSelector: NSObject {
    @IBOutlet var MixNameColumn: NSTableColumn!
    @IBOutlet var CoumnBeingControlled: AnyObject!
    @IBOutlet var FoodArrayController: AnyObject!
    @IBOutlet var ScrollViewBeingEdited: NSScrollView!
    
    private func addMGOptions() -> [NSBindingOption: Any] {
        return [.valueTransformerName: "addMG"]
    }
    
    private func addGramsOptions() -> [NSBindingOption: Any] {
        return [.valueTransformerName: "addGrams"]
    }
    
    private func updateColumn(keyPath: String, bindingOptions: [NSBindingOption: Any], header: String) {
        let initialWidth = MixNameColumn.width
        let finalwidth: CGFloat
        
        if initialWidth == 100 || initialWidth == 70 {
            finalwidth =  initialWidth - 1
        } else {
            finalwidth =  initialWidth + 1
        }
        
        MixNameColumn.resizingMask = .userResizingMask
        MixNameColumn.width = finalwidth
        
        CoumnBeingControlled.bind(.value, to: FoodArrayController as Any, withKeyPath: keyPath, options: bindingOptions)
        CoumnBeingControlled.headerCell?.stringValue = header
        
        ScrollViewBeingEdited.needsDisplay = true
        
        print("Itinial Width \(initialWidth)")
        print("Final Width \(finalwidth)")
    }
    
    @IBAction func CalciumSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.calciumValueAsDouble", bindingOptions: addMGOptions(), header: "  Calc")
    }
    
    @IBAction func CarbohydrateSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.carbsValueAsLong", bindingOptions: addGramsOptions(), header: "  Carbs")
    }
    
    @IBAction func CholesterolSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.cholesterolValueAsLong", bindingOptions: addMGOptions(), header: "  Chol")
    }
    
    @IBAction func DietaryFiberSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.dietaryFiberValueAsLong", bindingOptions: addGramsOptions(), header: "  Fiber")
    }
    
    @IBAction func IronSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.ironValueAsDouble", bindingOptions: addMGOptions(), header: "  Iron")
    }
    
    @IBAction func ProteinSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.proteinValueAsLong", bindingOptions: addGramsOptions(), header: "  Protein")
    }
    
    @IBAction func SaturatedFatSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.saturatedFatValueAsDouble", bindingOptions: addGramsOptions(), header: "  Sat Fat")
    }
    
    @IBAction func SodiumSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.sodiumValueAsLong", bindingOptions: addMGOptions(), header: "  Sodium")
    }
    
    @IBAction func SugarsSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.sugarsValueAsLong", bindingOptions: addGramsOptions(), header: "  Sugars")
    }
    
    @IBAction func TotalFatSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.totalFatValueAsDouble", bindingOptions: addGramsOptions(), header: "  Fat")
    }
    
    @IBAction func PolyFatSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.polyunsaturatedFatValueAsDouble", bindingOptions: addGramsOptions(), header: "  Poly-Fat")
    }
    
    @IBAction func MonoFatSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.monounsaturatedFatValueAsDouble", bindingOptions: addGramsOptions(), header: "  Mono-Fat")
    }
    
    @IBAction func VitaminASelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.vitaminAValueAsDouble", bindingOptions: addMGOptions(), header: "  Vit A")
    }
    
    @IBAction func VitaminCSelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.vitaminCValueAsDouble", bindingOptions: addMGOptions(), header: "  Vit C")
    }
    
    @IBAction func VitaminESelected(_ sender: AnyObject) {
        updateColumn(keyPath: "arrangedObjects.vitaminEValueAsDouble", bindingOptions: addMGOptions(), header: "  Vit E")
    }
}
