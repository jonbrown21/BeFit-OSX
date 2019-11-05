//
//  FoodArrayController.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/4/19.
//

import Foundation
import Cocoa

class FoodArrayController: NSArrayController {
    @IBOutlet var mPopupButton: NSPopUpButton!
    @IBOutlet var mCaloriesField: NSTextField!
    @IBOutlet var mCaloriesFieldPerc: NSTextField!
    @IBOutlet var mCaloriesFromFatField: NSTextField!
    @IBOutlet var mTotalFatField: NSTextField!
    @IBOutlet var mTotalFatPercentageField: NSTextField!
    @IBOutlet var mSaturatedFatField: NSTextField!
    @IBOutlet var mSaturatedFatPercentageField: NSTextField!
    @IBOutlet var mCholesterolField: NSTextField!
    @IBOutlet var mCholesterolPercentageField: NSTextField!
    @IBOutlet var mSodiumField: NSTextField!
    @IBOutlet var mSodiumPercentageField: NSTextField!
    @IBOutlet var mTotalCarbohydrateField: NSTextField!
    @IBOutlet var mTotalCarbPercentageField: NSTextField!
    @IBOutlet var mDietaryFiberField: NSTextField!
    @IBOutlet var mDietaryFiberPercentageField: NSTextField!
    @IBOutlet var mSugarField: NSTextField!
    @IBOutlet var mSugarFieldPerc: NSTextField!
    @IBOutlet var mProteinField: NSTextField!
    @IBOutlet var mProteinFieldPerc: NSTextField!
    @IBOutlet var mIronField: NSTextField!
    @IBOutlet var mIronFieldPerc: NSTextField!
    @IBOutlet var mVitCField: NSTextField!
    @IBOutlet var mVitCFieldPerc: NSTextField!
    @IBOutlet var mCalcField: NSTextField!
    @IBOutlet var mCalcFieldPerc: NSTextField!
    @IBOutlet var mAmountPerServingField: NSTextField!
    @IBOutlet var mDragSupport: FoodTableDragSupport!
    @IBOutlet var myTableView: NSTableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        mPopupButton.isHidden = true
    }
    
    override func remove(_ sender: Any?) {
        NSSound.beep()
        
        let alert = NSAlert()
        alert.addButton(withTitle: "Delete")
        alert.addButton(withTitle: "Cancel")
        alert.messageText = "Do you really want to delete this food item?"
        alert.informativeText = "Deleting this food item cannot be undone."
        alert.alertStyle = .warning
        
        if let window = NSApplication.shared.mainWindow {
            alert.beginSheetModal(for: window) {
                if $0 == .alertFirstButtonReturn {
                    super.remove(sender)
                    self.myTableView.reloadData()
                }
            }
        }
    }
    
    override func add(_ sender: Any?) {
        let flipMethod = NSApplication.shared.delegate as? BeFit_AppDelegate
        let newItem = self.newObject()
        addObject(newItem)
        flipMethod?.flip(self)
    }
    
    func updateTableEntry() {
        guard let tableView = mDragSupport.currentlyDisplayedTableView else {
            return
        }
        
        let selectedRows = tableView.selectedRowIndexes
        if let firstSelectedRow = selectedRows.first {
            tableView.setNeedsDisplay(tableView.rect(ofRow: firstSelectedRow))
        }
    }
    
    @IBAction func servingSizeChanged(_ sender: AnyObject!) {
        guard sender === mPopupButton else {
            return
        }
        
        let selectedObjects = self.selectedObjects as! [Food]
        guard let food = selectedObjects.first else {
            return
        }
        
        let formerIndex = food.indexOfServingBeingDisplayed
        let indexOfSelectedItem = Int64(mPopupButton.indexOfSelectedItem)
        
        if indexOfSelectedItem != formerIndex {
            food.setIndexOfServingBeingDisplayed(indexOfSelectedItem)
            mAmountPerServingField?.stringValue = food.servingAmountValue ?? ""
            mCaloriesField.stringValue = String(format: "%ld", food.caloriesLongValue)
            mCaloriesFieldPerc?.stringValue = String(format: "%ld", food.caloriesLongValue)
            mCaloriesFromFatField.stringValue = food.caloriesFromFatValue
            mTotalFatField.stringValue = food.totalFatValue
            mSaturatedFatField.stringValue = food.saturatedFatValue
            mSaturatedFatPercentageField.stringValue = food.saturatedFatPercent
            mCholesterolField.stringValue = food.cholesterolValue
            mCholesterolPercentageField.stringValue = food.cholesterolPercent
            mSodiumField.stringValue = food.sodiumValue
            mSodiumPercentageField.stringValue = food.sodiumPercent
            mTotalCarbohydrateField.stringValue = food.carbsValue
            mTotalCarbPercentageField.stringValue = food.carbsPercent
            mDietaryFiberField.stringValue = food.dietaryFiberValue
            mDietaryFiberPercentageField.stringValue = food.dietaryFiberPercent
            mTotalFatPercentageField.stringValue = food.totalFatPercent
            mSugarField.stringValue = food.sugarsValue
            mProteinField.stringValue = food.proteinValue
            mProteinFieldPerc.stringValue = food.proteinValuePerc
            mIronField.stringValue = food.ironValue
            mCalcField.stringValue = food.calciumValue
            mVitCField.stringValue = food.vitaminCValue
            mIronFieldPerc.stringValue = food.ironValuePerc
            mVitCFieldPerc.stringValue = food.vitaminCValuePerc
            mCalcFieldPerc.stringValue = food.calciumValuePerc
            mSugarFieldPerc.stringValue = food.sugarsValuePerc
            
            updateTableEntry()
        }
    }
    
    override func setSelectionIndexes(_ indexes: IndexSet) -> Bool {
        let okay = super.setSelectionIndexes(indexes)
        
        guard indexes.count == 1 else {
            return okay
        }
        
        guard mPopupButton != nil else {
            return okay
        }
        
        mPopupButton.removeAllItems()
        
        guard let food = selectedObjects.first as? Food else {
            return okay
        }
        
        let servingAmountValue = food.servingAmount1Value
        
        if servingAmountValue.count > 1 {
            if servingAmountValue == "1 ITEM" {
                mPopupButton.isHidden = true
            } else {
                mPopupButton.isHidden = false
            }
            
            mPopupButton.addItem(withTitle: servingAmountValue)
            
            let servingAmount2Value = food.servingAmount2Value ?? ""
            if servingAmount2Value.count > 1 {
                mPopupButton.addItem(withTitle: servingAmount2Value)
            }
            
            mPopupButton.selectItem(at: Int(food.indexOfServingBeingDisplayed))
        } else {
            mPopupButton.isHidden = true
        }
        
        return okay
    }
}
