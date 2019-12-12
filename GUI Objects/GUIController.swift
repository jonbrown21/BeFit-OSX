//
//  GUIController.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/5/19.
//

import Foundation
import Cocoa
import WebKit
import AppKit

class GUIController: NSObject, NSTableViewDelegate, NSWindowDelegate {
    @IBOutlet var FileMenu: NSMenu!
    @IBOutlet var FoodListsNSTableView: NSTableView!
    @IBOutlet var FoodNameColumn: NSTableColumn!
    @IBOutlet var MixNameColumn: NSTableColumn!
    @IBOutlet var CalNameCalumn: NSTableColumn!
    @IBOutlet var FoodNSTableView: NSTableView!
    @IBOutlet var FoodQuantityTableColumn: NSTableColumn!
    @IBOutlet var FoodRatingTableColumn: NSTableColumn!
    @IBOutlet var GraphPanelWinNSView: NSView!
    @IBOutlet var mainWindow: AnyObject!
    @IBOutlet var NutritionPanelDetailWinNSView: NSView!
    @IBOutlet var tableView2: NSTableView!
    @IBOutlet var NutritionPanelWinBackgroundNSView: NSView!
    @IBOutlet var PrintView: NSView!
    @IBOutlet var pieIndex1GraphView: WebView!
    @IBOutlet var foodGraphWebView: WebView!
    @IBOutlet var pieIndex2GraphView: WebView!
    @IBOutlet var pieIndex3GraphView: WebView!
    @IBOutlet var guageWebView: WebView!
    @IBOutlet var horizontalwebView: WebView!
    @IBOutlet var window: NSWindow!
    @IBOutlet var healthPopover: NSPopover!
    @IBOutlet var healthPopoverQtyOnly: NSPopover!
    @IBOutlet var topToolbar: NSToolbar!
    @IBOutlet var frontViewScrollView: NSScrollView!
    @IBOutlet var frontView: NSView!
    @IBOutlet var backView: NSView!
    @IBOutlet var showHideButton: NSButton!
    
    private func loadHTMLString(fromResource resource: String, to view: WebView?) {
        guard let path = Bundle.main.path(forResource: resource, ofType: "html") else {
            assertionFailure()
            return
        }
        
        guard let html = try? String(contentsOfFile: path, encoding: .utf8) else {
            assertionFailure()
            return
        }
        
        view?.mainFrame.frameView.allowsScrolling = false
        view?.mainFrame.loadHTMLString(html, baseURL: Bundle.main.resourceURL)
        view?.drawsBackground = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let sv = FoodNSTableView.enclosingScrollView
        sv?.scrollerStyle = .overlay
        var frame = tableView2.headerView?.frame ?? .zero
        frame.size.height = 26
        tableView2.headerView?.frame = frame

        pieIndex1GraphView.setValue(false, forKey: "drawsBackground")
        pieIndex2GraphView.setValue(false, forKey: "drawsBackground")
        pieIndex3GraphView.setValue(false, forKey: "drawsBackground")
        guageWebView.setValue(false, forKey: "drawsBackground")
        foodGraphWebView.setValue(false, forKey: "drawsBackground")
        horizontalwebView.setValue(false, forKey: "drawsBackground")
        
        // Is Dark Mode Enabled?
        enum InterfaceStyle : String {
           case Dark, Light

           init() {
              let type = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") ?? "Light"
              self = InterfaceStyle(rawValue: type)!
            }
        }
        
        let currentStyle = InterfaceStyle()
        
        // Set graphing system
        if currentStyle.rawValue == "Dark" {
            loadHTMLString(fromResource: "maingraph_dark", to: horizontalwebView)
            loadHTMLString(fromResource: "pieindex_dark", to: pieIndex1GraphView)
            loadHTMLString(fromResource: "pieindex2_dark", to: pieIndex2GraphView)
            loadHTMLString(fromResource: "pieindex3_dark", to: pieIndex3GraphView)
            loadHTMLString(fromResource: "foodgraph_dark", to: foodGraphWebView)
            loadHTMLString(fromResource: "gauge_dark", to: guageWebView)
        } else {
            
            loadHTMLString(fromResource: "maingraph", to: horizontalwebView)
            loadHTMLString(fromResource: "pieindex", to: pieIndex1GraphView)
            loadHTMLString(fromResource: "pieindex2", to: pieIndex2GraphView)
            loadHTMLString(fromResource: "pieindex3", to: pieIndex3GraphView)
            loadHTMLString(fromResource: "foodgraph", to: foodGraphWebView)
            loadHTMLString(fromResource: "gauge", to: guageWebView)
        }

        // Set preference defaults
        UserDefaults.standard.register(defaults: ["NSDisabledCharacterPaletteMenuItem": NSNumber(value: true)])
                
        tableView2.reloadData()
        
        // Set height of the TableHeader
        var frame_head = tableView2.headerView?.frame ?? .zero
        frame_head.size.height = 20
        tableView2.headerView?.frame = frame_head
        
        //Setting this so we can disable items in the menu
        FileMenu.autoenablesItems = false
        
        //Set Flip Value
        UserDefaults.standard.set(false, forKey: "flipPref")
        
        //Add the nutrition panel to the window
        
        frontViewScrollView.documentView?.setFrameSize(NSMakeSize(205, 1511))
        NutritionPanelWinBackgroundNSView.addSubview(frontViewScrollView)
        frontViewScrollView.documentView?.addSubview(frontView)
        
        if let documentView = frontViewScrollView.documentView {
                documentView.scroll(NSPoint(x: 0, y: documentView.bounds.size.height))
        }
        
        
        NutritionPanelWinBackgroundNSView.needsDisplay = true
        GraphPanelWinNSView.needsDisplay = true
        
        //Register the value transformers
        ValueTransformer.setValueTransformer(AddGramsValueTransformer(), forName: AddGramsValueTransformer.name)
        ValueTransformer.setValueTransformer(AddMGValueTransformer(), forName: AddMGValueTransformer.name)
        
        HideGraphPanel()
        
    }
    
    // Make some columns non-editable
    @objc func changeableColumnIsEditable() -> Bool {
        return false
    }
    
    // Important sets the columns as hidden or visible based on which one is selected. GuiController must be the delegate of the SourceList for this to work.
    func tableViewSelectionDidChange(_ notification: Notification) {
        //Sent when the food list changes we need to redraw the individual food table here to avoid drawing artifacts
        //Really this shouldn't be needed but seems Mac OS X might have a bug here at least on Tiger.
        FoodNSTableView.needsDisplay = true
        
        if FoodListsNSTableView.selectedRow == 0 || FoodListsNSTableView.selectedRow == 1 {
            FoodQuantityTableColumn.isHidden = true
            FoodRatingTableColumn.isHidden = false
        } else {
            FoodQuantityTableColumn.isHidden = false
            FoodRatingTableColumn.isHidden = false
        }
    }
    
    // Make some libraries non-editable
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let column = tableColumn else {
            return nil
        }
        
        guard let cellView = tableView.makeView(withIdentifier: column.identifier, owner: self) as? NSTableCellView else {
            return nil
        }
        
        let textField = cellView.textField
        textField?.isEditable = false
        return cellView
    }
    
    // Helper Functions for the Actions below
    func ShowGraphPanel() {
        if GraphPanelWinNSView.isHidden {
            ShowHideGraphPanel(self)
        }
    }
    
    func HideGraphPanel() {
        if !GraphPanelWinNSView.isHidden {
            ShowHideGraphPanel(self)
        }
    }
    
    // Quit the App if it is closed by pressing the red close button.
    func windowWillClose(_ notification: Notification) {
        NSApp.terminate(self)
    }
    
    @IBAction func ShowHideGraphPanel(_ sender: AnyObject) {
        //Change whatever the current setting is for the graph panel's hide/show value
        GraphPanelWinNSView.isHidden = !GraphPanelWinNSView.isHidden
        
        //Show/Hide the graph panel
        let currentFrame = FoodNSTableView.frame
        
        //We don't adjust the full height since one pixel is hidden of the graph panel
        let heightToAdjust = GraphPanelWinNSView.frame.size.height - 1
        
        if GraphPanelWinNSView.isHidden {
            var frameToUse = currentFrame
            frameToUse.size.height = frameToUse.size.height + heightToAdjust
            frameToUse.origin.y = frameToUse.origin.y - heightToAdjust

            FoodNSTableView.frame = frameToUse
        } else {
            var frameToUse = currentFrame
            frameToUse.size.height = frameToUse.size.height - heightToAdjust
            frameToUse.origin.y = frameToUse.origin.y + heightToAdjust

            FoodNSTableView.frame = frameToUse
        }

        FoodNSTableView.needsDisplay = true
        GraphPanelWinNSView.needsDisplay = true
    }
    
    @IBAction func print(_ sender: AnyObject) {
        let printInfo = NSPrintInfo.shared
        printInfo.verticalPagination = .automatic
        let horizontalMargin: CGFloat = -100
        let verticalMargin: CGFloat = -100
        
        printInfo.leftMargin = horizontalMargin
        printInfo.rightMargin = horizontalMargin
        printInfo.isHorizontallyCentered = true
        printInfo.topMargin = -600
        printInfo.bottomMargin = verticalMargin
        
        let printOperation = NSPrintOperation(view: PrintView)
        printOperation.canSpawnSeparateThread = true
        printOperation.runModal(for: window, delegate: nil, didRun: nil, contextInfo: nil)
    }
    
    @IBAction func pagesetup(_ sender: AnyObject) {
        let printInfo = NSPrintInfo.shared
        let pageLayout = NSPageLayout()
        pageLayout.beginSheet(with: printInfo, modalFor: window, delegate: nil, didEnd: nil, contextInfo: nil)
        //runs the model for the page layout UI.  It saves the global copy of printInfo in printOperation, which can be used to make decisions
    }
    
    @IBAction func ResizeCols(_ sender: AnyObject) {
        tableView2.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        FoodNameColumn.resizingMask = .userResizingMask
        CalNameCalumn.resizingMask = .userResizingMask
        MixNameColumn.resizingMask = .userResizingMask
        FoodQuantityTableColumn.resizingMask = .userResizingMask
        FoodRatingTableColumn.resizingMask = .userResizingMask
        
        CalNameCalumn.width = 70
        MixNameColumn.width = 70
        FoodQuantityTableColumn.width = 70
        FoodRatingTableColumn.width = 100
        FoodNameColumn.width = 300
    }
    
    @IBAction func ShowHideNutritionPanel(_ sender: AnyObject) {
        //Change whatever the current setting is for the nutrition panel's hide/show value
        NutritionPanelWinBackgroundNSView.isHidden = !NutritionPanelWinBackgroundNSView.isHidden
        //backView.isHidden = !backView.isHidden
        NutritionPanelDetailWinNSView.isHidden = !NutritionPanelDetailWinNSView.isHidden
        
        let currentFrame = FoodNSTableView.frame
        
        
        if NutritionPanelWinBackgroundNSView.isHidden {
            
            showHideButton.title = "Show"
            var frameToUse = currentFrame
            frameToUse.size.width = frameToUse.size.width + NutritionPanelWinBackgroundNSView.frame.size.width
            FoodNameColumn.width = FoodNameColumn.width + NutritionPanelWinBackgroundNSView.frame.size.width
                        
            frameToUse.size.width = frameToUse.size.width + NutritionPanelDetailWinNSView.frame.size.width
            FoodNameColumn.width = FoodNameColumn.width + NutritionPanelDetailWinNSView.frame.size.width
            
            FoodNSTableView.frame = frameToUse
            
            var graphFrame = GraphPanelWinNSView.frame
            graphFrame.size.width = graphFrame.size.width + NutritionPanelWinBackgroundNSView.frame.size.width
            GraphPanelWinNSView.frame = graphFrame

            var openGLFrame = horizontalwebView.frame
            openGLFrame.size.width = graphFrame.size.width
            GraphPanelWinNSView.frame = openGLFrame
            
            
        } else {
            
            showHideButton.title = "Hide"
            var frameToUse = currentFrame
            frameToUse.size.width = frameToUse.size.width - NutritionPanelWinBackgroundNSView.frame.size.width
            FoodNameColumn.width = FoodNameColumn.width - NutritionPanelWinBackgroundNSView.frame.size.width

            frameToUse.size.width = frameToUse.size.width - NutritionPanelWinBackgroundNSView.frame.size.width
            FoodNameColumn.width = FoodNameColumn.width - NutritionPanelWinBackgroundNSView.frame.size.width
            
            FoodNSTableView.frame = frameToUse
            
            var graphFrame = GraphPanelWinNSView.frame
            graphFrame.size.width = graphFrame.size.width - NutritionPanelWinBackgroundNSView.frame.size.width
            GraphPanelWinNSView.frame = graphFrame
            
            var openGLFrame = horizontalwebView.frame
            openGLFrame.size.width = graphFrame.size.width
            GraphPanelWinNSView.frame = openGLFrame
        }
    }
    
}
