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
    @IBOutlet var CholesteralLabel: AnyObject?
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
    @IBOutlet var NutritionPanelWinNSView: NSView!
    @IBOutlet var NutritionPanelDetailWinNSView: NSView!
    @IBOutlet var myScrollView: NSScrollView!
    @IBOutlet var finalView: NSView!
    @IBOutlet var tableView2: NSTableView!
    @IBOutlet var backView: NSView!
    @IBOutlet var NutritionPanelWinBackgroundNSView: AnyObject?
    @IBOutlet var myBackView: NSScrollView!
    @IBOutlet var finalBackView: NSView!
    @IBOutlet var PrintView: NSView!
    @IBOutlet var lowerGraphView: WebView?
    @IBOutlet var littleGraphView: WebView!
    @IBOutlet var littleGraphViewPrint: WebView!
    @IBOutlet var littleGraphView2: WebView!
    @IBOutlet var littleGraphView2Print: AnyObject?
    @IBOutlet var littleGraphView3: WebView!
    @IBOutlet var littleGraphView3Print: WebView!
    @IBOutlet var window: INAppStoreWindow!
    @IBOutlet var titleView: INTitlebarView!
    @IBOutlet var webView: WebView!
    @IBOutlet var healthPopover: NSPopover!
    @IBOutlet var healthPopoverQtyOnly: NSPopover!
    
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
        
        // Set graphing system
        
        loadHTMLString(fromResource: "index", to: webView)
        loadHTMLString(fromResource: "foodgraph", to: lowerGraphView)
        loadHTMLString(fromResource: "pieindex", to: littleGraphView)
        loadHTMLString(fromResource: "pieindex2", to: littleGraphView2)
        loadHTMLString(fromResource: "pieindex3", to: littleGraphView3)
        loadHTMLString(fromResource: "foodgraph", to: littleGraphViewPrint)
        loadHTMLString(fromResource: "gauge", to: littleGraphView3Print)
        
        // Set preference defaults
        UserDefaults.standard.register(defaults: ["NSDisabledCharacterPaletteMenuItem": NSNumber(value: true)])
        
        // Setup InAppStoreWindow
        
        self.window.trafficLightButtonsLeftMargin = 10.0
        self.window.centerTrafficLightButtons = false
        self.window.centerFullScreenButton = false
        self.window.titleBarHeight = 80.0
        self.window.trafficLightButtonsTopMargin = 10
        self.window.fullScreenButtonRightMargin = 5
        self.window.fullScreenButtonTopMargin = 5
        self.window.showsTitle = true
        self.titleView.frame = window.titleBarView.bounds
        self.titleView.autoresizingMask = [.width, .height]
        self.window.titleBarView.addSubview(titleView)
        
        tableView2.reloadData()
        
        // Set height of the TableHeader
        var frame_head = tableView2.headerView?.frame ?? .zero
        frame_head.size.height = 20
        tableView2.headerView?.frame = frame_head
        
        //    NSArray *columns = [tableView2 tableColumns];
        //    NSEnumerator *cols = [columns objectEnumerator];
        //    NSTableColumn *col = nil;
        //
        //    iTableColumnHeaderCell *iHeaderCell;
        //
        //    while (col = [cols nextObject]) {
        //    iHeaderCell = [[iTableColumnHeaderCell alloc]
        //    initTextCell:[[col headerCell] stringValue]];
        //    [col setHeaderCell:iHeaderCell];
        //    }

        //Setting this so we can disable items in the menu
        
        FileMenu.autoenablesItems = false
        
        //Add the nutrition panel to the window
        myScrollView.documentView = finalView
        let pt = NSPoint(x: 0, y: myScrollView.documentView?.bounds.height ?? 0)
        myScrollView.documentView?.scroll(pt)
        NutritionPanelWinNSView.needsDisplay = true
        GraphPanelWinNSView.needsDisplay = true
        
        //Register the value transformers
        ValueTransformer.setValueTransformer(AddGramsValueTransformer(), forName: AddGramsValueTransformer.name)
        ValueTransformer.setValueTransformer(AddMGValueTransformer(), forName: AddMGValueTransformer.name)
        
        HideGraphPanel()
        
        myBackView.documentView = finalBackView
        myBackView.backgroundColor = NSColor(patternImage: NSImage(named: "Black")!)
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
    
    // Actions
    @IBAction func loadSupport(_ sender: AnyObject) {
        if let url = URL(string: "http://www.jonbrown.org/support/") {
            NSWorkspace.shared.open(url)
        }
    }
    
    @IBAction func loadEmaildev(_ sender: AnyObject) {
        if let url = URL(string: "mailto:jon@jonbrown.org?subject=BeFit%20Feedback&body=Feedback") {
            NSWorkspace.shared.open(url)
        }
    }
    
    @IBAction func loadWebsite(_ sender: AnyObject) {
        if let url = URL(string: "http://osx.iusethis.com/app/befit") {
            NSWorkspace.shared.open(url)
        }
    }
    
    @IBAction func loadFacebook(_ sender: AnyObject) {
        if let url = URL(string: "http://www.facebook.com/sharer.php?s=100&p[url]=http://www.jonbrown.org/befit/&p[title]=BeFit&p[summary]=BeFit+is+the+ultimate+calorie+tracking+tool.+Based+on+the+nutrition+data+for+the+foods+that+you+eat.+Enter+the+coupon+code+%23BF2014+and+get+BeFit+at+30%25+off+for+a+limited+time%21") {
            NSWorkspace.shared.open(url)
        }
    }
    
    @IBAction func loadTwitter(_ sender: AnyObject) {
        if let url = URL(string: "http://twitter.com/share?url=http%3A%2F%2Fwww.jonbrown.org%2Fbefit%2F&via=JonBrownDesigns&text=BeFit+is+the+ultimate+calorie+tracking+tool.+Based+on+the+nutrition+data+for+the+foods+that+you+eat.+Enter+the+coupon+code+%23BF2014+and+get+BeFit+at+30%25+off+for+a+limited+time%21") {
            NSWorkspace.shared.open(url)
        }
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
        NutritionPanelWinNSView.isHidden = !NutritionPanelWinNSView.isHidden
        backView.isHidden = !backView.isHidden
        NutritionPanelDetailWinNSView.isHidden = !NutritionPanelDetailWinNSView.isHidden
        
        let currentFrame = FoodNSTableView.frame
        
        if NutritionPanelWinNSView.isHidden {
            var frameToUse = currentFrame
            frameToUse.size.width = frameToUse.size.width + NutritionPanelWinNSView.frame.size.width
            FoodNameColumn.width = FoodNameColumn.width + NutritionPanelWinNSView.frame.size.width
            
            frameToUse.size.width = frameToUse.size.width + backView.frame.size.width
            FoodNameColumn.width = FoodNameColumn.width + backView.frame.size.width
            
            frameToUse.size.width = frameToUse.size.width + NutritionPanelDetailWinNSView.frame.size.width
            FoodNameColumn.width = FoodNameColumn.width + NutritionPanelDetailWinNSView.frame.size.width
            
            FoodNSTableView.frame = frameToUse
            
            var graphFrame = GraphPanelWinNSView.frame
            graphFrame.size.width = graphFrame.size.width + NutritionPanelWinNSView.frame.size.width
            GraphPanelWinNSView.frame = graphFrame

            var openGLFrame = webView.frame
            openGLFrame.size.width = graphFrame.size.width
            GraphPanelWinNSView.frame = openGLFrame
        } else {
            var frameToUse = currentFrame
            frameToUse.size.width = frameToUse.size.width - NutritionPanelWinNSView.frame.size.width
            FoodNameColumn.width = FoodNameColumn.width - NutritionPanelWinNSView.frame.size.width
            
            frameToUse.size.width = frameToUse.size.width - backView.frame.size.width
            FoodNameColumn.width = FoodNameColumn.width - backView.frame.size.width

            frameToUse.size.width = frameToUse.size.width - NutritionPanelDetailWinNSView.frame.size.width
            FoodNameColumn.width = FoodNameColumn.width - NutritionPanelDetailWinNSView.frame.size.width
            
            FoodNSTableView.frame = frameToUse
            
            var graphFrame = GraphPanelWinNSView.frame
            graphFrame.size.width = graphFrame.size.width - NutritionPanelWinNSView.frame.size.width
            GraphPanelWinNSView.frame = graphFrame
            
            var openGLFrame = webView.frame
            openGLFrame.size.width = graphFrame.size.width
            GraphPanelWinNSView.frame = openGLFrame
        }
    }
    
    @IBAction func showHealthPopup(_ sender: NSView) {
        healthPopover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
    }
    
    @IBAction func showHealthPopupQtyOnly(_ sender: NSView) {
        healthPopoverQtyOnly.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
    }
}
