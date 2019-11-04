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
    @IBOutlet var myView: NSView!
    @IBOutlet var myTableView: NSTableView!
    
    func setupHeaderCell() {
        for column in tableColumns {
            let cell = column.headerCell
            let newCell = iTableColumnHeaderCell(cell: cell)!
            column.headerCell = newCell
        }
    }
    
    func setupCornerView() {
        let cornerView = self.cornerView ?? NSView()
        let newCornerView = CustomCornerView(frame: cornerView.frame)
        self.cornerView = newCornerView
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupHeaderCell()
        setupCornerView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerForDraggedTypes([.foodDataDragType])
    }
    
    // Draw the flat color selection of the NSTableView
    override func highlightSelection(inClipRect clipRect: NSRect) {
        // this method is asking us to draw the hightlights for
        // all of the selected rows that are visible inside theClipRect

        // 1. get the range of row indexes that are currently visible
        // 2. get a list of selected rows
        // 3. iterate over the visible rows and if their index is selected
        // 4. draw our custom highlight in the rect of that row.
        
        let aVisibleRowIndexes = rows(in: clipRect)
        let aSelectedRowIndexes = selectedRowIndexes
        let aRow = aVisibleRowIndexes.location
        let anEndRow = aRow + aVisibleRowIndexes.length
        
        let gradient: NSGradient
        let pathColor: NSColor
        
        if self == self.window?.firstResponder &&
            self.window?.isMainWindow ?? false &&
            self.window?.isKeyWindow ?? false {
            gradient = NSGradient(colorsAndLocations:
                (NSColor(deviceRed: 128/255, green: 157/255, blue: 194/255, alpha: 1), 0),
                (NSColor(deviceRed: 128/255, green: 157/255, blue: 194/255, alpha: 1), 1)
                ) ?? NSGradient()
            
            pathColor = NSColor(deviceRed: 128/255, green: 157/255, blue: 194/255, alpha: 1)
        } else {
            gradient = NSGradient(colorsAndLocations:
            (NSColor(deviceRed: 186/255, green: 192/255, blue: 203/255, alpha: 1), 0),
            (NSColor(deviceRed: 186/255, green: 192/255, blue: 203/255, alpha: 1), 1)
            ) ?? NSGradient()
            
            pathColor = NSColor(deviceRed: 186/255, green: 192/255, blue: 203/255, alpha: 1)
        }
        
        // draw highlight for the visible, selected rows
        
        for row in aRow ..< anEndRow {
            if aSelectedRowIndexes.contains(row) {
                let aRowRect = NSInsetRect(rect(ofRow: row), 0, 0)
                let path = NSBezierPath(rect: aRowRect)
                gradient.draw(in: path, angle: 90)
            }
        }
    }
    
    // we need to override this to return nil
    // or we'll see the default selection rectangle when the app is running
    // in any OS before leopard

    // you can also return a color if you simply want to change the table's default selection color
    
    func highlightColorForCell(_ cell: NSCell) -> AnyObject? {
        return nil
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
        let currentlySelectedFoodLists = FoodListController.selectedObjects as! [FoodList]
        let currentFoodList = currentlySelectedFoodLists.first
        myTableView.reloadData()
    }
}
