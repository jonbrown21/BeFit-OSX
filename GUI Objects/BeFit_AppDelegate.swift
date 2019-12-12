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
    @IBOutlet var ToggleSwitch: NSSegmentedControl!
    @IBOutlet var EyeSwitch: NSButton!
    @IBOutlet var NutritionPanelWinBackgroundNSView: NSView!
    @IBOutlet var frontViewScrollView: NSScrollView!
    @IBOutlet var frontView: NSView!
    @IBOutlet var backView: NSView!
    @IBOutlet var bmiView: NSView!
    @IBOutlet var updateItem: NSMenuItem!
    @IBOutlet var lbsName: NSTextField!
    @IBOutlet var feetname: NSTextField!
    @IBOutlet var inchname: NSTextField!
    @IBOutlet var kgname: NSTextField!
    @IBOutlet var cmname: NSTextField!
    @IBOutlet var agename: NSTextField!
    @IBOutlet var prefslider: NSSlider!
    @IBOutlet var sliderValueLabel: NSTextField!
    @IBOutlet var gendercheck: NSPopUpButton!
    @IBOutlet var metricheck: NSButton!
    @IBOutlet var bmiValue: NSTextField!
    @IBOutlet var weightGoals: NSPopUpButton!
    @IBOutlet var lifeStyle: NSPopUpButton!
    @IBOutlet var Answer: NSTextField!
    @IBOutlet var Recomend: NSButton!
    @IBOutlet var formattedSliderValue: NSTextField!
    @IBOutlet var updateMenuItem: NSMenuItem!
    @IBOutlet var updateMenuLine: NSMenuItem!
    
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
        
        #if STORE
        updateItem.isHidden = true
        updateMenuLine.isHidden = true
        #endif
        
        LBSChecker(nil)
        FeetChecker(nil)
        InchesChecker(nil)
        cmChecker(nil)
        kgChecker(nil)
        ageChecker(nil)
        bmiCalculator(nil)
        formattedSliderValue.isHidden = true
        
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
        
    @IBAction func bmiLoadBack(_ sender: AnyObject) {
        
        if let documentView = frontViewScrollView.documentView {
                documentView.scroll(NSPoint(x: 0, y: documentView.bounds.size.height))
        }
        
        let flipin = UserDefaults.standard.bool(forKey: "flipPref")
        UserDefaults.standard.set(false, forKey: "flipPref")
        print("Flip Preference: \(flipin)")
        
        let animation = CATransition()
        animation.type = CATransitionType(rawValue: "cube")
        animation.subtype = .fromRight
        animation.duration = 0.65
        animation.delegate = self as? CAAnimationDelegate
        
        frontViewScrollView.documentView?.wantsLayer = true // Turn on backing layer
        frontViewScrollView.documentView?.animations = ["subviews" : animation]
        
        frontViewScrollView.documentView?.setFrameSize(NSMakeSize(205, 1511))
        frontViewScrollView.documentView?.animator().replaceSubview(bmiView, with: frontView)
            
        if let documentView = frontViewScrollView.documentView {
                documentView.scroll(NSPoint(x: 0, y: documentView.bounds.size.height))
        }
        
    }
    
    @IBAction func bmiLoad(_ sender: AnyObject) {
        
        
        if let documentView = frontViewScrollView.documentView {
                documentView.scroll(NSPoint(x: 0, y: documentView.bounds.size.height))
        }
        
        let flipin = UserDefaults.standard.bool(forKey: "flipPref")
        UserDefaults.standard.set(true, forKey: "flipPref")
        print("Flip Preference: \(flipin)")
        
        let animation = CATransition()
        animation.type = CATransitionType(rawValue: "cube")
        animation.subtype = .fromLeft
        animation.duration = 0.65
        animation.delegate = self as? CAAnimationDelegate
        
        frontViewScrollView.documentView?.wantsLayer = true // Turn on backing layer
        frontViewScrollView.documentView?.animations = ["subviews" : animation]
        
        frontViewScrollView.documentView?.setFrameSize(NSMakeSize(205, 1511))
        frontViewScrollView.documentView?.animator().replaceSubview(frontView, with: bmiView)
            
        if let documentView = frontViewScrollView.documentView {
                documentView.scroll(NSPoint(x: 0, y: documentView.bounds.size.height))
        }
        
        
    }
    
    @IBAction func flip(_ sender: AnyObject) {
        
        let flipin = UserDefaults.standard.bool(forKey: "flipPref")
        UserDefaults.standard.set(true, forKey: "flipPref")
        print("Flip Preference: \(flipin)")
        
        let animation = CATransition()
        animation.type = CATransitionType(rawValue: "cube")
        animation.subtype = .fromLeft
        animation.duration = 0.65
        animation.delegate = self as? CAAnimationDelegate
        frontViewScrollView.documentView?.setFrameSize(NSMakeSize(205, 1511))

        frontViewScrollView.documentView?.wantsLayer = true // Turn on backing layer

        frontViewScrollView.documentView?.animations = ["subviews" : animation]
        frontViewScrollView.documentView?.animator().replaceSubview(frontView, with: backView)
        
        
        
        if let documentView = frontViewScrollView.documentView {
                documentView.scroll(NSPoint(x: 0, y: documentView.bounds.size.height))
        }
    }
    
    @IBAction func flipback(_ sender: AnyObject) {
        
        let animation = CATransition()
        animation.type = CATransitionType(rawValue: "cube")
        animation.subtype = .fromRight
        animation.duration = 0.65
        animation.delegate = self as? CAAnimationDelegate
        frontViewScrollView.documentView?.setFrameSize(NSMakeSize(205, 1511))
        
        frontViewScrollView.documentView?.wantsLayer = true // Turn on backing layer
        
        frontViewScrollView.documentView?.animations = ["subviews" : animation]
        frontViewScrollView.documentView?.animator().replaceSubview(backView, with: frontView)
        
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
    
    
    //MARK: - BMI Actions
        
        private var defaults: UserDefaults {
            return .standard
        }
    
        @IBAction func LBSChecker(_ sender: AnyObject?) {
            let lbspref = defaults.string(forKey: "lbs-name")
            
            if lbspref?.isEmpty ?? true {
                lbsName.stringValue = ""
            } else {
                lbsName.stringValue = lbspref ?? ""
            }
            
            // Set Format for LBS Field
            let lbsnameformatter = NumberFormatter()
            lbsnameformatter.format = "#,###;0;(#,##0)"
            lbsName.cell?.formatter = lbsnameformatter
        }
        
        @IBAction func FeetChecker(_ sender: AnyObject?) {
            let feetpref = defaults.string(forKey: "feet-name")
            // Read default prefrences for member name
            if feetpref?.isEmpty ?? true {
                feetname.stringValue = ""
            } else {
                feetname.stringValue = feetpref ?? ""
            }
            
            // Set Format for LBS Field
            let feetnameformatter = NumberFormatter()
            feetnameformatter.format = "#,###;0;(#,##0)"
            feetname.cell?.formatter = feetnameformatter
        }
        
        @IBAction func InchesChecker(_ sender: AnyObject?) {
            let inchpref = defaults.string(forKey: "inch-name")
            
            if inchpref?.isEmpty ?? true {
                inchname.stringValue = ""
            } else {
                inchname.stringValue = inchpref ?? ""
            }
            
            // Set Format for LBS Field
            let inchnameformatter = NumberFormatter()
            inchnameformatter.format = "#,###;0;(#,##0)"
            inchname.cell?.formatter = inchnameformatter
        }
        
        @IBAction func cmChecker(_ sender: AnyObject?) {
            let cmpref = defaults.string(forKey: "cm-name")
            
            if cmpref?.isEmpty ?? true {
                cmname.stringValue = ""
            } else {
                cmname.stringValue = cmpref ?? ""
            }
            
            // Set Format for LBS Field
            let cmnameformatter = NumberFormatter()
            cmnameformatter.format = "#,###;0;(#,##0)"
            cmname.cell?.formatter = cmnameformatter
        }
        
        @IBAction func kgChecker(_ sender: AnyObject?) {
            let kgpref = defaults.string(forKey: "kg-name")
            
            if kgpref?.isEmpty ?? true {
                kgname.stringValue = ""
            } else {
                kgname.stringValue = kgpref ?? ""
            }
            
            // Set Format for LBS Field
            let kgnameformatter = NumberFormatter()
            kgnameformatter.format = "#,###;0;(#,##0)"
            kgname.cell?.formatter = kgnameformatter
        }
        
        @IBAction func ageChecker(_ sender: AnyObject?) {
            let agepref = defaults.string(forKey: "age-name")
            
            if agepref?.isEmpty ?? true {
                agename.stringValue = ""
            } else {
                agename.stringValue = agepref ?? ""
            }
            
            // Set Format for LBS Field
            let agenameformatter = NumberFormatter()
            agenameformatter.format = "#,###;0;(#,##0)"
            agename.cell?.formatter = agenameformatter
        }
        
        @IBAction func bmiCalculator(_ sender: AnyObject?) {
            let agepref = defaults.string(forKey: "age-name")
            let cmpref = defaults.string(forKey: "cm-name")
            let kgpref = defaults.string(forKey: "kg-name")
            
            let inchpref = defaults.string(forKey: "inch-name")
            let feetpref = defaults.string(forKey: "feet-name")
            let lbspref = defaults.string(forKey: "lbs-name")
            
            //let metricpref = defaults.string(forKey: "self.checkBoxChecked")
            let metricvalue = defaults.string(forKey: "metric-name")
            let gendervalue = defaults.string(forKey: "gender-name")
            let lifestylevalue = defaults.string(forKey: "lifestyle-name")
            let goalsvalue = defaults.string(forKey: "goals-name")
            //let goalvalue = defaults.string(forKey: "goal-name")
            
            let feet = feetpref.flatMap { Int($0) } ?? 0
            let inches = inchpref.flatMap { Float($0) } ?? 0
            let totalWeight = lbspref.flatMap { Float($0) } ?? 0
            let totalCM = cmpref.flatMap { Float($0) } ?? 0
            let metercheck = metricvalue.flatMap { Float($0) } ?? 0
            let gender = gendervalue.flatMap { Float($0) } ?? 0
            let age = agepref.flatMap { Float($0) } ?? 0
            let lbs = lbspref.flatMap { Float($0) } ?? 0
            let lifestyles = lifestylevalue.flatMap { Float($0) } ?? 0
            let goals = goalsvalue.flatMap { Float($0) } ?? 0
            let inch = totalCM * 0.393701
            
            var totalKG: Float = 0
            var lbsconv: Float = 0
            var totalMeters: Float = 0
            var BMI: Float = 0
            var BMR: Float = 0
            var totalInches: Float = 0
            
            if metercheck == 1 {
                totalKG = kgpref.flatMap { Float($0) } ?? 0
                lbsconv = totalKG / 0.453592
                totalMeters = totalCM / 100
                BMI = totalKG / (totalMeters * totalMeters)
                
                let finishedBMI = String(format: "%.f", BMI)
                let bmiFloatValue = Float(finishedBMI) ?? 0
                let theRange: String
                
                if bmiFloatValue < 16.5 {
                    theRange = "Underweight"
                } else if bmiFloatValue < 18.5 {
                    theRange = "Underweight"
                } else if bmiFloatValue < 27 {
                    theRange = "Normal"
                } else if bmiFloatValue < 30 {
                    theRange = "Overweight";
                } else if bmiFloatValue < 35 {
                    theRange = "Obese"
                } else {
                    theRange = "Obese"
                }
                
                let finalBMIOutput = String(format: "BMI: %.f | Rating: %@", BMI, theRange)
                bmiValue.stringValue = finalBMIOutput
                
                defaults.set(finishedBMI, forKey: "bmi-value")
                
                // Calculate BMR
                if gender == 0 {
                    BMR = 655 + (4.35 * lbsconv) + (4.7 * inch) - (4.7 * age)
                } else {
                    BMR = 66 + (6.23 * lbsconv) + (12.7 * inch) - (6.8 * age)
                }
                
                print("BMR IS \(BMR)")
            } else {
                totalInches = (Float(feet) * 12) + inches
                BMI = totalWeight / (totalInches * totalInches) * 703
                let finishedBMI = String(format: "%.f", BMI)
                let bmiFloatValue = Float(finishedBMI) ?? 0
                let theRange: String
                
                print("Total Inches: \(totalInches)")
                
                if bmiFloatValue < 16.5 {
                    theRange = "Underweight"
                } else if bmiFloatValue < 18.5 {
                    theRange = "Underweight"
                } else if bmiFloatValue < 27 {
                    theRange = "Normal"
                } else if bmiFloatValue < 30 {
                    theRange = "Overweight"
                } else if bmiFloatValue < 35 {
                    theRange = "Obese"
                } else {
                    theRange = "Obese"
                }
                
                let finalBMIOutput = String(format: "BMI: %.f | Rating: %@", BMI, theRange)
                bmiValue.stringValue = finalBMIOutput
                
                defaults.set(finishedBMI, forKey: "bmi-value")
                
                // Calculate BMR
                if gender == 0 {
                    BMR = 655 + (4.35 * lbs) + (4.7 * totalInches) - (4.7 * age)
                    print("BMR LBS IS \(lbs)")
                    print("BMR IN IS \(totalInches)")
                } else {
                    BMR =  66 + (6.23 * lbs) + (12.7 * totalInches) - (6.8 * age)
                }
                
                print("BMR IS \(BMR)")
            }
            
            // Calculate Lifestyle
            let BMRLIFESTYLE: Float
            
            if lifestyles == 0 {
                BMRLIFESTYLE = BMR * 1.2
            } else if lifestyles == 1 {
                BMRLIFESTYLE = BMR * 1.375
            } else if lifestyles == 2 {
                BMRLIFESTYLE = BMR * 1.55
            } else if lifestyles == 3 {
                BMRLIFESTYLE = BMR * 1.725
            } else if lifestyles == 4 {
                BMRLIFESTYLE = BMR * 1.9
            } else {
                BMRLIFESTYLE = 0
            }
            
            // Calculate Goals
            let BMRGOALS: Float
            
            if goals == 0 {
                BMRGOALS = BMRLIFESTYLE - 500
            } else if goals == 1 {
                BMRGOALS = BMRLIFESTYLE + 1000
            } else if goals == 2 {
                BMRGOALS = BMRLIFESTYLE
            } else {
                BMRGOALS = BMRLIFESTYLE
            }
            
            Answer.floatValue = BMRGOALS
            
            // Set Format for Answer Field
            let answerformatter = NumberFormatter()
            answerformatter.format = "#,###;0;(#,##0)"
            Answer.cell?.formatter = answerformatter
            
            let recomendPref = Recomend.stringValue
            let rec = Float(recomendPref) ?? 0
            let slide = Answer.floatValue
            
            let mySlide = NSNumber(value: slide).stringValue
            formattedSliderValue.stringValue = mySlide
            
            let slidePrefSetter = formattedSliderValue.stringValue
            
            if rec == 0 {
                prefslider.isEnabled = true
            } else {
                defaults.set(slidePrefSetter, forKey: "goal-name")
                prefslider.stringValue = slidePrefSetter
                sliderValueLabel.stringValue = slidePrefSetter
                print("Recomended String Value is: \(slidePrefSetter)")
                print("Recomended Float Value is: \(slide)")
                print("Recommended Pref is: \(rec)")
                
                prefslider.isEnabled = false
            }
        }
        
        @IBAction func setMetric(_ sender: AnyObject?) {
            let metricPref = metricheck.stringValue
            
            if sender === metricheck {
                defaults.set(metricPref, forKey: "metric-name")
            } else {
                bmiCalculator(nil)
                print("Metric value is: \(metricPref)")
            }
        }
        
        @IBAction func setLifestyle(_ sender: AnyObject?) {
            let indexInteger = lifeStyle.indexOfSelectedItem
            let indexIntegerString = String(format: "%li", indexInteger)
            
            if sender === lifeStyle {
                defaults.set(indexIntegerString, forKey: "lifestyle-name")
                bmiCalculator(nil)
                print("Lifestyle is: \(indexInteger)")
            }
        }
        
        @IBAction func setRecomendation(_ sender: AnyObject?) {
            let recomendPref = Recomend.stringValue
            
            if sender === Recomend {
                defaults.set(recomendPref, forKey: "recommend-name")
                bmiCalculator(nil)
                print("Metric value is: \(recomendPref)")
            }
        }
        
        @IBAction func setGoals(_ sender: AnyObject?) {
            let indexInteger = weightGoals.indexOfSelectedItem
            let indexIntegerString = String(format: "%li", indexInteger)
            
            if sender === weightGoals {
                defaults.set(indexIntegerString, forKey: "goals-name")
                bmiCalculator(nil)
                print("Goals are: \(indexInteger)")
            }
        }
        
        @IBAction func setGender(_ sender: AnyObject?) {
            let indexInteger = gendercheck.indexOfSelectedItem
            let indexIntegerString = String(format: "%li", indexInteger)
            
            if sender === gendercheck {
                defaults.set(indexIntegerString, forKey: "gender-name")
                bmiCalculator(nil)
                print("Gender is: \(indexInteger)")
            }
        }
        
        @IBAction func setWeightLBS(_ sender: AnyObject?) {
            // Set default prefrences for Member Name
            let num1 = lbsName.floatValue
            let num2 = lbsName.stringValue
            let lbsnamed = lbsName.stringValue
            
            if num1 <= 0 {
                if num2.isEmpty {
                    if sender === lbsName {
                        defaults.set(lbsnamed, forKey: "lbs-name")
                        bmiCalculator(nil)
                        print("LBS value is: \(lbsnamed)")
                    }
                } else {
                    let alert = NSAlert()
                    alert.messageText = "Please enter a value between 0 and 350 lbs."
                    alert.runModal()
                }
            } else if num1 > 350 {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 350 lbs."
                alert.runModal()
            } else {
                if sender === lbsName {
                    defaults.set(lbsnamed, forKey: "lbs-name")
                    bmiCalculator(nil)
                    print("LBS value is: \(lbsnamed)")
                }
            }
        }
        
        @IBAction func setFeet(_ sender: AnyObject?) {
            // Set default prefrences for Member Name
            let num2 = feetname.floatValue
            let num3 = feetname.stringValue
            
            let feetnamed = feetname.stringValue
            
            if num2 <= 0 {
                if num3.isEmpty {
                    if sender === feetname {
                        defaults.set(feetnamed, forKey: "feet-name")
                        bmiCalculator(nil)
                        print("Feet value is: \(feetnamed)")
                    }
                } else {
                    let alert = NSAlert()
                    alert.messageText = "Please enter a value between 0 and 10 lbs."
                    alert.runModal()
                }
            } else if num2 > 10 {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 10 lbs."
                alert.runModal()
            } else {
                if sender === feetname {
                    defaults.set(feetnamed, forKey: "feet-name")
                    bmiCalculator(nil)
                    print("Feet value is: \(feetnamed)")
                }
            }
        }
        
        @IBAction func setInches(_ sender: AnyObject?) {
            // Set default prefrences for Member Name
            let num3 = inchname.floatValue
            let num4 = inchname.stringValue
            
            let inchnamed = inchname.stringValue
            
            if num3 <= 0 {
                if num4.isEmpty {
                    if sender === inchname {
                        defaults.set(inchnamed, forKey: "inch-name")
                        bmiCalculator(nil)
                        print("Inch value is: \(inchnamed)")
                    }
                } else {
                    let alert = NSAlert()
                    alert.messageText = "Please enter a value between 0 and 12 lbs."
                    alert.runModal()
                }
            } else if num3 > 12 {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 12 lbs."
                alert.runModal()
            } else {
                if sender === inchname {
                    defaults.set(inchnamed, forKey: "inch-name")
                    bmiCalculator(nil)
                    print("Inch value is: \(inchnamed)")
                }
            }
        }
        
        @IBAction func setCM(_ sender: AnyObject?) {
            // Set default prefrences for Member Name
            let num3 = cmname.floatValue
            let num4 = cmname.stringValue
            
            let cmnamed = cmname.stringValue
            
            if num3 <= 0 {
                if num4.isEmpty {
                    if sender === cmname {
                        defaults.set(cmnamed, forKey: "cm-name")
                        bmiCalculator(nil)
                        print("CM value is: \(cmnamed)")
                    }
                } else {
                    let alert = NSAlert()
                    alert.messageText = "Please enter a value between 0 and 300 cm."
                    alert.runModal()
                }
            } else if num3 > 300 {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 300 cm."
                alert.runModal()
            } else {
                if sender === cmname {
                    defaults.set(cmnamed, forKey: "cm-name")
                    bmiCalculator(nil)
                    print("CM value is: \(cmnamed)")
                }
            }
        }
        
        @IBAction func setKG(_ sender: AnyObject?) {
            // Set default prefrences for Member Name
            
            let num3 = kgname.floatValue
            let num4 = kgname.stringValue
            
            let kgnamed = kgname.stringValue
            
            if num3 <= 0 {
                if num4.isEmpty {
                    if sender === kgname {
                        defaults.set(kgnamed, forKey: "kg-name")
                        bmiCalculator(nil)
                        print("KG value is: \(kgnamed)")
                    }
                } else {
                    let alert = NSAlert()
                    alert.messageText = "Please enter a value between 0 and 300 cm."
                    alert.runModal()
                }
            } else if num3 > 300 {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 300 cm."
                alert.runModal()
            } else {
                if sender === kgname {
                    defaults.set(kgnamed, forKey: "kg-name")
                    bmiCalculator(nil)
                    print("KG value is: \(kgnamed)")
                }
            }
        }
        
        @IBAction func setAge(_ sender: AnyObject?) {
            // Set default preferences for Member Name
            let num3 = agename.floatValue
            let num4 = agename.stringValue
            
            let agenamed = agename.stringValue
            
            if num3 <= 0 {
                if num4.isEmpty {
                    if sender === agename {
                        defaults.set(agenamed, forKey: "age-name")
                        bmiCalculator(nil)
                        print("Age value is: \(agenamed)")
                    }
                } else {
                    let alert = NSAlert()
                    alert.messageText = "Please enter a value between 0 and 100."
                    alert.runModal()
                }
            } else if num3 > 100 {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 100."
                alert.runModal()
            } else {
                if sender === agename {
                    defaults.set(agenamed, forKey: "age-name")
                    bmiCalculator(nil)
                    print("Age value is: \(agenamed)")
                }
            }
        }

}
