//
//  FoodNSTableView.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/4/19.
//

import Foundation
import Cocoa

class FoodNSTableView: NSTableView {
    @IBOutlet var FoodController: AnyObject!
    @IBOutlet var FoodListController: AnyObject!
    @IBOutlet var myTableView: NSTableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerForDraggedTypes([.foodDataDragType])
    }
    
    @IBAction func DeleteSelectedObjectInTableView(_ sender: Any?) {
        let currentlySelectedFoodLists = FoodListController.selectedObjects as! [FoodList]
        let selectedObjects = FoodController.selectedObjects
        print(selectedObjects?.first as Any)
        let entity = selectedObjects?.first as? Food
        print(entity?.userDefined as Any)
        
        var foodsCanBeRemoved = true
        let user = entity?.userDefined?.intValue ?? 0
        
        for list in currentlySelectedFoodLists {
            if list.orderIndex?.intValue ?? 0 == 0 {
                if user == 0 {
                    foodsCanBeRemoved = false
                }
            }
        }
        
        if foodsCanBeRemoved {
            FoodController.remove(sender)
        } else {
            NSSound.beep()
        }
    }
    
    override func textDidEndEditing(_ notification: Notification) {
        super.textDidEndEditing(notification)
        
        myTableView.reloadData()
    }
}
