//
//  FoodTableDragSupport.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/5/19.
//

import Foundation
import Cocoa

class FoodTableDragSupport: NSObject, NSTableViewDataSource, NSTableViewDelegate {
    private var mDisplayedTableView: NSTableView?
    
    var currentlyDisplayedTableView: NSTableView? {
        return mDisplayedTableView
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        mDisplayedTableView = tableView
        return 0 // return 0 so the table view will fall back to getting data from its binding
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return nil // return nil so the table view will fall back to getting data from its binding
    }
    
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {
        guard let bindingInfo = tableView.infoForBinding(.content) else {
            return false
        }
        
        guard let arrayController = bindingInfo[.observedObject] as? NSArrayController else {
            return false
        }
        
        let arrangedObjects = arrayController.arrangedObjects as! [NSManagedObject]
        
        // Collect URI representation of managed objects
        let objectURIs = rowIndexes.compactMap { row -> URL? in
            guard row < arrangedObjects.count else {
                return nil
            }
            
            let object = arrangedObjects[row]
            return object.objectID.uriRepresentation()
        }
        
        pboard.declareTypes([.foodDataDragType], owner: nil)
        pboard.setData(NSArchiver.archivedData(withRootObject: objectURIs), forType: .foodDataDragType)
        
        return true
    }
}
