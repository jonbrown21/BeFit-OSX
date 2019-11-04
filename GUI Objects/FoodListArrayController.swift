//
//  FoodListArrayController.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/4/19.
//

import Foundation
import Cocoa

class FoodListArrayController: NSArrayController {
    @IBOutlet var addFood: AnyObject!
    
    var libraryIsSelected: Bool {
        for currentFoodList in selectedObjects {
            if let list = currentFoodList as? FoodList {
                let orderIndex = list.orderIndex?.intValue ?? 0
                if orderIndex == 0 || orderIndex == 1 {
                    return true
                }
            }
        }
        
        return false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sortDescriptors = [NSSortDescriptor(key: "orderIndex", ascending: true)]
    }
    
    func reindexEntries() {
        // Note: use a temporary array since modifying an item in arrangedObjects
        //directly will cause the sort to trigger thus throwing off
        //the re-indexing.
        
        let objects = arrangedObjects as! [FoodList]
        
        for (i, object) in objects.enumerated() {
            object.orderIndex = NSNumber(value: i)
        }
    }
    
    override func remove(_ sender: Any?) {
        if !libraryIsSelected {
            NSSound.beep()
            let alert = NSAlert()
            alert.addButton(withTitle: "Delete")
            alert.addButton(withTitle: "Cancel")
            alert.messageText = "Do you really want to delete this food list?"
            alert.informativeText = "Deleting this food list cannot be undone."
            alert.alertStyle = .warning
            if let window = NSApplication.shared.mainWindow {
                alert.beginSheetModal(for: window) {
                    switch $0 {
                    case .alertFirstButtonReturn:
                        super.remove(sender)
                        self.reindexEntries()
                    default:
                        break
                    }
                }
            }
        } else {
            NSSound.beep()
        }
    }
    
    override func insert(_ object: Any, atArrangedObjectIndex index: Int) {
        (object as? FoodList)?.orderIndex = NSNumber(value: index)
        super.insert(object, atArrangedObjectIndex: index)
        
        reindexEntries()
    }
    
}
