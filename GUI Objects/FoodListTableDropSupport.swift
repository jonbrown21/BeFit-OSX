//
//  FoodListTableDropSupport.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/5/19.
//

import Foundation
import Cocoa

class FoodListTableDropSupport: NSObject, NSTableViewDelegate, NSTableViewDataSource {
    @IBOutlet var ApplicationDelegate: BeFit_AppDelegate!
    @IBOutlet var myTableView: NSTableView!
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 0 // return 0 so the table view will fall back to getting data from its binding
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return nil // return nil so the table view will fall back to getting data from its binding
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        switch dropOperation {
        case .on:
            return .copy
        default:
            return []
        }
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        guard let infoForBinding = tableView.infoForBinding(.content) else {
            return false
        }
        
        guard let arrayController = infoForBinding[.observedObject] as? NSArrayController else {
            return false
        }
        
        let arrangedObjects = arrayController.arrangedObjects as! [FoodList]
        
        guard row < arrangedObjects.count else {
            return false
        }
        
        let foodListToModify = arrangedObjects[row]
        
        guard let context = ApplicationDelegate?.managedObjectContext else {
            return false
        }
        
        let data = info.draggingPasteboard.data(forType: .foodDataDragType) ?? Data()
        guard let objectURIs = NSUnarchiver.unarchiveObject(with: data) as? [URL] else {
            return false
        }
        
        for currentObjectURI in objectURIs {
            guard let objectID = context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: currentObjectURI) else {
                continue
            }
            
            guard let foodObject = context.object(with: objectID) as? Food else {
                continue
            }
            
            foodListToModify.addToFoods(foodObject)
        }
        
        myTableView.reloadData()
        return true
    }
}
