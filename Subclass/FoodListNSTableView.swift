//
//  FoodListNSTableView.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/4/19.
//

import Foundation
import Cocoa

extension NSPasteboard.PasteboardType {
    static let foodDataDragType = Self("FoodDataDragType")
}

class FoodListNSTableView: NSTableView,
NSTableViewDelegate {
    @IBOutlet var FoodListController: AnyObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerForDraggedTypes([.foodDataDragType])
    }
    
    @IBAction func DeleteSelectedObjectInTableView(_ sender: Any?) {
        FoodListController.remove(sender)
    }
    
    //- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row
    //{
    //    NSLog(@"row =%ld",row);
    //    JBDCustomRow *rowView = [[JBDCustomRow alloc]init];
    //    return rowView;
    //}
}
