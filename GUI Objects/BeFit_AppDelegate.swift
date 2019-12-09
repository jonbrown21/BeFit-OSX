//
//  BeFit_AppDelegate.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/5/19.
//

import Foundation
import Cocoa

#if WEBSITE
//import Sparkle
import Paddle
#endif

private let LEFT_VIEW_INDEX = 0
private let LEFT_VIEW_PRIORITY = 2
private let LEFT_VIEW_MINIMUM_WIDTH: CGFloat = 200
private let MAIN_VIEW_INDEX = 1
private let MAIN_VIEW_PRIORITY = 0
private let MAIN_VIEW_MINIMUM_WIDTH: CGFloat = 735
private let APP_SUPPORT_SUBDIR = "BeFit"
private let DATABASE_FILE = "BeFit2.dat"

@NSApplicationMain
class BeFit_AppDelegate: NSObject, NSApplicationDelegate, NSTableViewDelegate, NSWindowDelegate {
    @IBOutlet var LevelInd: NSLevelIndicator!
    @IBOutlet var LevelInd2: NSLevelIndicator!
    @IBOutlet var LevelInd3: NSLevelIndicator!
    @IBOutlet var LevelInd4: NSLevelIndicator!
    @IBOutlet var LevelInd5: NSLevelIndicator!
    @IBOutlet var LevelInd6: NSLevelIndicator!
    @IBOutlet var LevelInd7: NSLevelIndicator!
    @IBOutlet var Cals: NSTextField!
    @IBOutlet var SaveWindow: NSWindow!
    @IBOutlet var window: NSWindow!
    @IBOutlet var splitView: NSSplitView!
    @IBOutlet var FoodTableView: NSArrayController!
    @IBOutlet var arrayController_: NSArrayController!
    @IBOutlet var tableView_: NSTableView!
    @IBOutlet var PrintView: NSView!
    @IBOutlet var food_name: NSTextField!
    @IBOutlet var calories: NSTextField!
    @IBOutlet var protein: NSTextField!
    @IBOutlet var carbohydrates: NSTextField!
    @IBOutlet var dietary_fiber: NSTextField!
    @IBOutlet var sugar: NSTextField!
    @IBOutlet var calcium: NSTextField!
    @IBOutlet var iron: NSTextField!
    @IBOutlet var sodium: NSTextField!
    @IBOutlet var vitC: NSTextField!
    @IBOutlet var vitA: NSTextField!
    @IBOutlet var vitE: NSTextField!
    @IBOutlet var saturated_fat: NSTextField!
    @IBOutlet var monounsaturated_fat: NSTextField!
    @IBOutlet var polyunsaturated_fat: NSTextField!
    @IBOutlet var cholesterol: NSTextField!
    @IBOutlet var gmwt1: NSTextField!
    @IBOutlet var gmwt_desc1: NSTextField!
    @IBOutlet var ToggleSwitch: NSSegmentedControl!
    @IBOutlet var EyeSwitch: NSButton!
    @IBOutlet var NutritionPanelWinBackgroundNSView: NSView!
    @IBOutlet var frontView: NSView!
    @IBOutlet var backView: NSView!
    @IBOutlet var frontViewScrollView: NSScrollView!
    @IBOutlet var backViewScrollView: NSScrollView!
    
    private var splitViewDelegate: PrioritySplitViewDelegate!
    private var focusedAdvancedControlIndex: Int = 0
    
    /**
     Returns the persistent store coordinator for the application.  This
     implementation will create and return a coordinator, having added the
     store for the application to it.  (The folder for the store is created,
     if necessary.)
     */
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let paths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        guard let pathString = paths.first else {
            fatalError()
        }
        
        let applicationSupportFolder = (pathString as NSString).appendingPathComponent(APP_SUPPORT_SUBDIR)
        
        do {
            if !FileManager.default.fileExists(atPath: applicationSupportFolder) {
                try FileManager.default.createDirectory(atPath: applicationSupportFolder, withIntermediateDirectories: true, attributes: nil)
            }
            
            guard let resourcePath = Bundle.main.resourcePath else {
                throw CustomError.unknown
            }
            
            let dataFilePath = (applicationSupportFolder as NSString).appendingPathComponent(DATABASE_FILE)
            
            if !FileManager.default.fileExists(atPath: dataFilePath) {
                try FileManager.default.copyItem(atPath: (resourcePath as NSString).appendingPathComponent(DATABASE_FILE), toPath: dataFilePath)
            }
            
            let url = URL(fileURLWithPath: dataFilePath)
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: NSNumber(value: true),
                NSInferMappingModelAutomaticallyOption: NSNumber(value: true)
            ]
            
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
            
            return coordinator
        } catch let error {
            NSApplication.shared.presentError(error)
            fatalError(String(describing: error))
        }
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        var allBundles = [Bundle.main]
        allBundles.append(contentsOf: Bundle.allFrameworks)
        
        return NSManagedObjectModel.mergedModel(from: allBundles)!
    }()
    
    /**
       Returns the managed object context for the application (which is already
       bound to the persistent store coordinator for the application.)
    */
    @objc lazy var managedObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()
       
    /**
       Returns the NSUndoManager for the application.  In this case, the manager
       returned is that of the managed object context for the application.
    */
    func windowWillReturnUndoManager(_ window: NSWindow) -> UndoManager? {
        return managedObjectContext.undoManager
    }
    
    /**
       Performs the save action for the application, which is to send the save:
       message to the application's managed object context.  Any encountered errors
       are presented to the user.
    */
    private func trySaveManagedObjectContext() {
        do {
            try managedObjectContext.save()
        } catch let error {
            NSApplication.shared.presentError(error)
            fatalError(String(describing: error))
        }
    }
    
    @IBAction func saveAction(_ sender: AnyObject) {
        trySaveManagedObjectContext()
        
        window.beginSheet(SaveWindow, completionHandler: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.SaveWindow.orderOut(nil)
            self.window.endSheet(self.SaveWindow)
        }
    }
    
    @objc func contSave(_ autoSave: Timer) {
        trySaveManagedObjectContext()
        
    }
    
    
    
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        UserDefaults.standard.set(false, forKey: "NSConstraintBasedLayoutLogUnsatisfiable")
        UserDefaults.standard.set(false, forKey: "__NSConstraintBasedLayoutLogUnsatisfiable")
        
        let lbspref = UserDefaults.standard.object(forKey: "goal-name") as? NSNumber
        let yourLong = lbspref?.doubleValue ?? 0
        
        // Calories Level Ind.
        LevelInd.maxValue = yourLong
        LevelInd.warningValue = yourLong / 3
        LevelInd.criticalValue = yourLong / 2
        
        // Cholesterol and Carbs Level Ind.
        LevelInd2.maxValue = 300
        LevelInd2.warningValue = 300 / 3
        LevelInd2.criticalValue = 300 / 2
        
        LevelInd3.maxValue = 300
        LevelInd3.warningValue = 300 / 3
        LevelInd3.criticalValue = 300 / 2
        
        // Protein Ind.
        
        LevelInd4.maxValue = 50
        LevelInd4.warningValue = 50 / 3
        LevelInd4.criticalValue = 50 / 2
        
        // Sodium Ind.
        
        LevelInd5.maxValue = 2400
        LevelInd5.warningValue = 2400 / 3
        LevelInd5.criticalValue = 2400 / 2
        
        // Fiber Ind.
        
        LevelInd6.maxValue = 25
        LevelInd6.warningValue = 25 / 3
        LevelInd6.criticalValue = 25 / 2
        
        // Total Fat Ind.
        
        LevelInd7.maxValue = 50
        LevelInd7.warningValue = 50 / 3
        LevelInd7.criticalValue = 50 / 2
                
        // Set Default Preference Values
        
        let flipin = UserDefaults.standard.bool(forKey: "flipPref")
        UserDefaults.standard.set(false, forKey: "flipPref")
        print("Flip Preferences: \(flipin)")
        
        // Check if Trial and if so ask if they want to move this app to applications folder.
        
        #if WEBSITE
        _ = PADDisplayConfiguration.init(PADDisplayType.sheet, hideNavigationButtons: false, parentWindow: self.window)
        
        // Check if Trial and if so present expired message
        let myPaddleVendorID = "25300"
        let myPaddleProductID = "520775"
        let myPaddleAPIKey = "411430c46d02e5a5bc45c309068cd6e7"

        // Default Product Config in case we're unable to reach our servers on first run
        let defaultProductConfig = PADProductConfiguration()
        defaultProductConfig.productName = "BeFit"
        defaultProductConfig.vendorName = "Grove Designs"
        

        // Initialize the SDK singleton with the config
        let paddle = Paddle.sharedInstance(withVendorID: myPaddleVendorID,
                                           apiKey: myPaddleAPIKey,
                                           productID: myPaddleProductID,
                                           configuration: defaultProductConfig,
                                           delegate:self as? PaddleDelegate)

        // Initialize the Product you'd like to work with

        let paddleProduct = PADProduct(productID: myPaddleProductID,
                                       productType: PADProductType.sdkProduct,
                                       configuration: defaultProductConfig)

        // Ask the Product to get its latest state and info from the Paddle Platform
        paddleProduct?.refresh({ (delta: [AnyHashable : Any]?, error: Error?) in
            // Optionally show the default "Product Access" UI to gatekeep your app
            
            paddle?.showProductAccessDialog(with: paddleProduct!)
            
        })
        
        #endif
        
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(contSave), userInfo: nil, repeats: true)
                
        splitViewDelegate = PrioritySplitViewDelegate()
        splitViewDelegate.setPriority(LEFT_VIEW_PRIORITY, forViewAt: LEFT_VIEW_INDEX)
        splitViewDelegate.setMinimumLength(LEFT_VIEW_MINIMUM_WIDTH, forViewAt: LEFT_VIEW_INDEX)
        splitViewDelegate.setPriority(MAIN_VIEW_PRIORITY, forViewAt: MAIN_VIEW_INDEX)
        splitViewDelegate.setMinimumLength(MAIN_VIEW_MINIMUM_WIDTH, forViewAt: MAIN_VIEW_INDEX)
        
        splitView.delegate = splitViewDelegate
        
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        trySaveManagedObjectContext()
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        trySaveManagedObjectContext()
        
        splitView.delegate = nil
    }
    
    /**
       Implementation of the applicationShouldTerminate: method, used here to
       handle the saving of changes in the application managed object context
       before the application terminates.
    */
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        if !managedObjectContext.commitEditing() {
            return .terminateCancel
        }
        
        if !managedObjectContext.hasChanges {
            return .terminateNow
        }
        
        do {
            try managedObjectContext.save()
        } catch let error {
            let result = sender.presentError(error)
            if result {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting.  Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info")
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        
        return .terminateNow
    }
    
    @IBAction func flip(_ sender: AnyObject) {
        
        let flipin = UserDefaults.standard.bool(forKey: "flipPref")
        UserDefaults.standard.set(true, forKey: "flipPref")
        print("Flip Preference: \(flipin)")
        
        let animation = CATransition()
        animation.type = CATransitionType(rawValue: "rippleEffect")
        animation.subtype = .fromLeft
        animation.duration = 0.85
        animation.delegate = self as? CAAnimationDelegate
        
        NutritionPanelWinBackgroundNSView.wantsLayer = true // Turn on backing layer
        NutritionPanelWinBackgroundNSView.animations = ["subviews" : animation]
        NutritionPanelWinBackgroundNSView.animator().replaceSubview(frontView, with:  backView)
        
        if let documentView = backViewScrollView.documentView {
                documentView.scroll(NSPoint(x: 0, y: documentView.bounds.size.height))
        }
    }
    
    @IBAction func flipback(_ sender: AnyObject) {
        
        let animation = CATransition()
        animation.type = CATransitionType(rawValue: "rippleEffect")
        animation.subtype = .fromRight
        animation.duration = 0.85
        animation.delegate = self as? CAAnimationDelegate
        
        NutritionPanelWinBackgroundNSView.wantsLayer = true // Turn on backing layer
        NutritionPanelWinBackgroundNSView.animations = ["subviews" : animation]
        NutritionPanelWinBackgroundNSView.animator().replaceSubview(backView, with:  frontView)
        
        if let documentView = frontViewScrollView.documentView {
                       documentView.scroll(NSPoint(x: 0, y: documentView.bounds.size.height))
               }
        
        let flipin = UserDefaults.standard.bool(forKey: "flipPref")
        UserDefaults.standard.set(false, forKey: "flipPref")
        print("Flip Preference: \(flipin)")
        
        window.beginSheet(SaveWindow, completionHandler: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.SaveWindow.orderOut(nil)
            self.window.endSheet(self.SaveWindow)
        }
        
    }

    
    //MARK: - NSTableViewDelegate
    
    //MARK: - Printing Variables
    
    @objc var goalPref: String {
        let lbspref = UserDefaults.standard.string(forKey: "goal-name") ?? ""
        return String(format: "%@ / per day", lbspref)
    }
    
    @objc var goalsPref: String {
        let lbspref = UserDefaults.standard.string(forKey: "goals-name") ?? ""
        let yourLong = Int64(lbspref) ?? 0
        
        switch yourLong {
        case 0:
            return "Loose Weight"
        case 1:
            return "Gain Weight"
        default:
            if yourLong < 0 {
                return "Undefined"
            }
            return "Maintain Weight"
        }
    }
    
    func windowWillClose(_ notification: Notification) {
        NSApp.terminate(self)
    }
}
