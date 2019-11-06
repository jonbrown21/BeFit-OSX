//
//  BeFit_AppDelegate.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/5/19.
//

import Foundation
import Cocoa

#if TRIAL || WEBSITE
import Sparkle
import Paddle
#endif

private let LEFT_VIEW_INDEX = 0
private let LEFT_VIEW_PRIORITY = 2
private let LEFT_VIEW_MINIMUM_WIDTH: CGFloat = 200
private let MAIN_VIEW_INDEX = 1
private let MAIN_VIEW_PRIORITY = 0
private let MAIN_VIEW_MINIMUM_WIDTH: CGFloat = 735

#if TRIAL || STORE
private let APP_SUPPORT_SUBDIR = "BeFit Trial"
private let DATABASE_FILE = "BeFit2D.dat"
#else
private let APP_SUPPORT_SUBDIR = "BeFit"
private let DATABASE_FILE = "BeFit2.dat"
#endif

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
    @IBOutlet var SendWindow: NSWindow!
    @IBOutlet var myProgress: NSProgressIndicator!
    @IBOutlet var window: NSWindow!
    @IBOutlet var SavingLabel: NSTextField!
    @IBOutlet var splitView: NSSplitView!
    @IBOutlet var isOnline: NSImageView!
    @IBOutlet var FoodTableView: NSArrayController!
    @IBOutlet var submitFood: NSButton!
    @IBOutlet var openFeedback: OpenFeedback?
    
    @IBOutlet var showStore: NSWindow!
    @IBOutlet var arrayController_: NSArrayController!
    @IBOutlet var tableView_: NSTableView!
    @IBOutlet var frontView: NSView!
    @IBOutlet var backView: NSView!
    @IBOutlet var hostView: NSView!
    
    @IBOutlet var backScrollView: NSScrollView!
    @IBOutlet var myScrollView: NSScrollView!
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
    
    @IBOutlet var CalorieScrollView: LNScrollView!
    @IBOutlet var progressBar: ITProgressBar!
    @IBOutlet var mySuperview: NSView?
    
    private var flipController: MCViewFlipController!
    private var splitViewDelegate: PrioritySplitViewDelegate!
    private var segment: ANSegmentedControl!
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
        //applicationSupportFolder = [self applicationSupportFolder];
        //NSString *aappSupportFolder = [applicationSupportFolder stringByAppendingPathComponent: @"BeFit"];
        
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
     Returns the support folder for the application, used to store the Core Data
     store file.  This code uses a folder named "BeFit" for
     the content, either in the NSApplicationSupportDirectory location or (if the
     former cannot be found), the system's temporary directory.
     */
    
    //- (NSString *)applicationSupportFolder
    //{
    //    NSArray * paths;
    //
    //    paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    //    if([paths count] > 0 )
    //    {
    //        return( [paths objectAtIndex: 0] );
    //    }
    //
    //    /* else, return a path to the resource directory */
    //    return [[NSBundle mainBundle] resourcePath];
    //}
    
    
    /**
     Creates, retains, and returns the managed object model for the application
     by merging all of the models found in the application bundle and all of the
     framework bundles.
     */
    
    // Setup the UA App Review Manager
    
    static func setupUAAppReviewManager() {
        #if WEBSITE || TRIAL || STORE
        UAAppReviewManager.setAppID("854891012")
        #else
        UAAppReviewManager.setAppID("402924047")
        #endif
        
        UAAppReviewManager.setDebug(true)
    }
    
    // Trigger the UA App Review Manager
    @IBAction func presentStandardPrompt(_ sender: AnyObject) {
        UAAppReviewManager.showPrompt { trackingInfo in
            // This is the block syntx for showing prompts.
            // It lets you decide if it should be shown now or not based on
            // the UAAppReviewManager trackingInfo or any other factor.
            print("UAAppReviewManager trackingInfo: \(String(describing: trackingInfo))")
            // Don't show the prompt now, but do it from the buttons in the example app
            return true
        }
        
        // YES here means it is ok to show, it is the only override to Debug == YES.
        UAAppReviewManager.userDidSignificantEvent(true)
    }
    
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
        
        myProgress.startAnimation(self)
        window.beginSheet(SaveWindow, completionHandler: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.SaveWindow.orderOut(nil)
            self.window.endSheet(self.SaveWindow)
        }
    }
    
    @objc func contSave(_ autoSave: Timer) {
        trySaveManagedObjectContext()
        
        SavingLabel.stringValue = "SAVING..."
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.SavingLabel.stringValue = ""
        }
    }
    
    func checkInternet() -> Bool {
        guard let url = URL(string: "http://www.google.com") else {
            return false
        }
        
        do {
            try NSURLConnection.sendSynchronousRequest(URLRequest(url: url), returning: nil)
            return true
        } catch {
            return false
        }
    }
    
    @objc func onlineCheck(_ labelCheck: Timer) {
        if checkInternet() {
            let connected = NSImage(named: "Green")
            isOnline.image = connected
            isOnline.toolTip = "Online"
            isOnline.needsDisplay = true
        } else {
            let notConnected = NSImage(named: "Grey")
            isOnline.image = notConnected
            isOnline.toolTip = "Offline"
            isOnline.needsDisplay = true
        }
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        BeFit_AppDelegate.setupUAAppReviewManager()
        
        let notConnected = NSImage(named: "Grey")
        isOnline.image = notConnected
        isOnline.toolTip = "Offline"
        isOnline.needsDisplay = true
        
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
        
        // Present Rating Window if needed.
        
        UAAppReviewManager.showPromptIfNecessary()
        
        // Set Default Preference Values
        
        let flipin = UserDefaults.standard.bool(forKey: "flipPref")
        UserDefaults.standard.set(false, forKey: "flipPref")
        print("Flip Preferencess: \(flipin)")
        
        // Check if Trial and if so ask if they want to move this app to applications folder.
        
        #if TRIAL || WEBSITE
        PFMoveToApplicationsFolderIfNecessary()
        openFeedback?.presentPanelIfCrashed()
        
        // Check if Trial and if so present expired message
        let paddle = Paddle.sharedInstance()
        paddle.setProductId("520775")
        paddle.setVendorId("25300")
        paddle.setApiKey("411430c46d02e5a5bc45c309068cd6e7")
        
        let productInfo = [
            kPADCurrentPrice: "4.99",
            kPADDevName: "Jon Brown Designs",
            kPADCurrency: "USD",
            kPADProductName: "BeFit",
            kPADTrialDuration: "30",
            kPADTrialText: "Thanks for downloading a trial of BeFit for Mac",
            kPADProductImage: "icon_512x512.png" //Image file in your project
        ]
        
        Paddle.sharedInstance().startLicensing(productInfo, timeTrial: true, with: window)
        #endif
        
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(onlineCheck), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(contSave), userInfo: nil, repeats: true)
        
        CalorieScrollView.setPattern(NSImage(named: "Black"))
        
        splitViewDelegate = PrioritySplitViewDelegate()
        splitViewDelegate.setPriority(LEFT_VIEW_PRIORITY, forViewAt: LEFT_VIEW_INDEX)
        splitViewDelegate.setMinimumLength(LEFT_VIEW_MINIMUM_WIDTH, forViewAt: LEFT_VIEW_INDEX)
        splitViewDelegate.setPriority(MAIN_VIEW_PRIORITY, forViewAt: MAIN_VIEW_INDEX)
        splitViewDelegate.setMinimumLength(MAIN_VIEW_MINIMUM_WIDTH, forViewAt: MAIN_VIEW_INDEX)
        
        splitView.delegate = splitViewDelegate
        
        window.center()
        window.makeKeyAndOrderFront(self)
        
        flipController = MCViewFlipController(hostView: hostView, frontView: frontView, back: backView)
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
        flipController.flip(self)
        let pt = NSPoint(x: 0, y: backScrollView.documentView?.bounds.size.height ?? 0)
        backScrollView.documentView?.scroll(pt)
        
        let pt2 = NSPoint(x: 0, y: myScrollView.documentView?.bounds.size.height ?? 0)
        myScrollView.documentView?.scroll(pt2)
        
        //We can remove a food unless it is in the library
        
        let selectedObjects = FoodTableView.selectedObjects as! [Food]
        
        guard let entity = selectedObjects.first else {
            return
        }
        
        let user = entity.userDefined?.boolValue ?? false
        print(entity)
        print(user)
        
        if !user {
            submitFood.isEnabled = false
        } else {
            submitFood.isEnabled = true
            let flipin = UserDefaults.standard.bool(forKey: "flipPref")
            print("Checkbox Status: \(submitFood.state)")
            print("Flip Preference: \(flipin)")
            
            if flipin && submitFood.state == .on {
                SendFood(self)
                progressBar.animates = progressBar.animates
                //[self.progressBar.animator setFloatValue:0];
                progressBar.floatValue = 0
                
                window.beginSheet(SendWindow, completionHandler: nil)
                
                Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.SendWindow.orderOut(self)
                    self.window.endSheet(self.SendWindow)
                }
            }
        }
    }
    
    @objc private func timerFired(_ theTimer: Timer) {
        if !(progressBar.floatValue == 1) {
            _ = theTimer.isValid
            
            progressBar.floatValue = 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.progressBar.floatValue = 0
            }
        } else {
            theTimer.invalidate()
        }
    }
    
    @IBAction func SendFood(_ sender: AnyObject) {
        let food_name2 = food_name.stringValue
        let calories2 = calories.doubleValue
        let protein2 = protein.doubleValue
        let carbohydrates2 = carbohydrates.doubleValue
        let dietary_fiber2 = dietary_fiber.doubleValue
        let sugar2 = sugar.doubleValue
        let calcium2 = calcium.doubleValue
        let iron2 = iron.doubleValue
        let sodium2 = sodium.doubleValue
        let vitC2 = vitC.doubleValue
        let vitA2 = vitA.doubleValue
        let vitE2 = vitE.doubleValue
        let saturated_fat2 = saturated_fat.doubleValue
        let monounsaturated_fat2 = monounsaturated_fat.doubleValue
        let polyunsaturated_fat2 = polyunsaturated_fat.doubleValue
        let cholesterol2 = cholesterol.doubleValue
        let gmwt12 = gmwt1.doubleValue
        let gmwt_desc12 = gmwt_desc1.stringValue
        
        if checkInternet() {
            // Register Reg Code
            print("web request started")
            let post = String(format: "food_name=%@&calories=%f&protein=%f&carbohydrates=%f&dietary_fiber=%f&sugar=%f&calcium=%f&iron=%f&sodium=%f&vitC=%f&vitA=%f&vitE=%f&saturated_fat=%f&monounsaturated_fat=%f&polyunsaturated_fat=%f&cholesterol=%f&gmwt1=%f&gmwt_desc1=%@", food_name2, calories2, protein2, carbohydrates2, dietary_fiber2, sugar2, calcium2, iron2, sodium2, vitC2, vitA2, vitE2, saturated_fat2, monounsaturated_fat2, polyunsaturated_fat2, cholesterol2, gmwt12, gmwt_desc12)
            
            guard let postData = post.data(using: .utf8),
                let url = URL(string: "http://products.jonbrown.org/tracker/customer_befit.php") else {
                assertionFailure()
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(String(postData.count), forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = postData
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    print("connection received response")
                    
                    if let err = error {
                        print("Conn Err: \(err.localizedDescription)")
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        print("Invalid HTTP response")
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        print("connection state is \(httpResponse.statusCode) - all okay")
                    } else {
                        print("connection state is NOT 200")
                    }
                }
            }.resume()
            
            print("connection initiated")
        } else {
            print("Offline")
            let alert = NSAlert()
            alert.messageText = "You need to be online to save custom food entries to the cloud."
            alert.runModal()
        }
    }
    
    //MARK: - NSTableViewDelegate
    
    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        for column in tableView.tableColumns {
            let cell = column.headerCell as? iTableColumnHeaderCell
            let ascending: Bool
            let priority: Int
            
            if column == tableColumn {
                ascending = arrayController_.sortDescriptors.first?.ascending ?? false
                priority = 0
            } else {
                ascending = false
                priority = 1
            }
            
            cell?.setSortAscending(ascending, priority: priority)
        }
    }
    
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
    
    @IBAction func showStore(_ sender: AnyObject) {
        window.beginSheet(showStore, completionHandler: nil)
    }
    
    @IBAction func hideStore(_ sender: AnyObject) {
        showStore.orderOut(nil)
        window.endSheet(showStore)
    }
}
